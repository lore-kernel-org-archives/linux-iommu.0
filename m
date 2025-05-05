Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751BD2F2A
	for <iommu@lists.linux.dev>; Mon,  5 May 2025 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456308; cv=none; b=EodC/11HoMzq3y0V+w02+CvnC8K70EEdoiv+bH7thlUCM2GkVmrBRPDWRpJF2Obhbr6grs2gxNJCETT+/WpS61HZp5I8X/37ashWBId56Zkv6npt9p4IN5o4uu4j274CZrlX/XN41+MTlFmxu9d0lXQdv2zdBwNFoAZxQ0CvhTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456308; c=relaxed/simple;
	bh=X4CcqKEFiPXnLVmOkcgxEGdZ4BwJ2BeWQo+GaY9sRy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUqcHbA3yzzuJ48gnZscY3IeKH6XDASshej31LQuEbPHrS+S4JE2hTcbz75I0CS+c8eruDHalATaSBG+oq4tzY7N/KYPbrmieyBzLRcN9V9CNJheZsGvCFlWjxN+k0/OoeSsXfFWwkEOX9bhIuBjvmaVPd8MfW33nW67R2MhOyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrhB5NAV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrhB5NAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4BFC4CEE4;
	Mon,  5 May 2025 14:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746456307;
	bh=X4CcqKEFiPXnLVmOkcgxEGdZ4BwJ2BeWQo+GaY9sRy0=;
	h=From:To:Cc:Subject:Date:From;
	b=HrhB5NAVYPr15bI+/aYD/3VCpYUrUr1U83OIzchuATL0aCE8d2g9NlGFp4o7EyJad
	 yq4EAQRkxCvMSOzl4NbZRAEN24Df1Nw39STm2KNmFVdo0f0WOcPR7cUCvh72/OLi7t
	 rLRPcdF848RVrpSWZEHjgy84sG4o5fGbxotJuLXhFwUeMLVZPe4R3HPz1IEnEgtxhA
	 9D5R6SKxQmPnS03KzFZEXSywgeeWQLUjBgYd0XFrrVTHgokqNyFBqi/+IzyxzN8ZmV
	 UhFfIc575krb/b46SHwM8tH+iOzAlf9MEvUwN5aJHQvPFp9OHv7FWAL5mIrD7esjTA
	 Af/IL7iX4ZyMw==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	joro@8bytes.org,
	will@kernel.org
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <Vasant.Hegde@amd.com>,
	Paul Blinzer <Paul.Blinzer@amd.com>,
	iommu@lists.linux.dev
Subject: [PATCH v2] iommu/amd: Allow matching ACPI HID devices without matching UIDs
Date: Mon,  5 May 2025 09:44:50 -0500
Message-ID: <20250505144451.326555-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

A BIOS upgrade has changed the IVRS DTE UID for a device that no
longer matches the UID in the SSDT. In this case there is only
one ACPI device on the system with that _HID but the _UID mismatch.

IVRS:
```
[1E4h 0484 001h]               Subtable Type : F0 [Device Entry: ACPI HID Named Device]
[1E5h 0485 002h]                   Device ID : 0060
[1E7h 0487 001h] Data Setting (decoded below) : 40
                                    INITPass : 0
                                    EIntPass : 0
                                     NMIPass : 0
                                    Reserved : 0
                                 System MGMT : 0
                                  LINT0 Pass : 1
                                  LINT1 Pass : 0
[1E8h 0488 008h]                    ACPI HID : "MSFT0201"
[1F0h 0496 008h]                    ACPI CID : 0000000000000000
[1F8h 0504 001h]                  UID Format : 02
[1F9h 0505 001h]                  UID Length : 09
[1FAh 0506 009h]                         UID : "\_SB.MHSP"
```

SSDT:
```
Device (MHSP)
{
    Name (_ADR, Zero)  // _ADR: Address
    Name (_HID, "MSFT0201")  // _HID: Hardware ID
    Name (_UID, One)  // _UID: Unique ID
```

To handle this case; while enumerating ACPI devices in get_acpihid_device_id()
count the number of matching ACPI devices with a matching _HID. If there is
exactly one _HID match then accept it even if the UID doesn't match. Other
operating systems allow this, but the current IVRS spec doesn't explicitly
allow or disallow it. Output 'Firmware Bug' for this case to encourage it to
be solved in the BIOS.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Use FW_BUG
 * Update commit message
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Vasant Hegde <Vasant.Hegde@amd.com>
Cc: Paul Blinzer <Paul.Blinzer@amd.com>
---
 drivers/iommu/amd/iommu.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b19e8c0f48fa2..06f747d2f964c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -109,7 +109,8 @@ static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
-	struct acpihid_map_entry *p;
+	struct acpihid_map_entry *p, *p1;
+	bool fw_bug;
 
 	if (!adev)
 		return -ENODEV;
@@ -117,11 +118,26 @@ static inline int get_acpihid_device_id(struct device *dev,
 	list_for_each_entry(p, &acpihid_map, list) {
 		if (acpi_dev_hid_uid_match(adev, p->hid,
 					   p->uid[0] ? p->uid : NULL)) {
-			if (entry)
-				*entry = p;
-			return p->devid;
+			p1 = p;
+			fw_bug = false;
+			break;
+		}
+
+		/* In ase there is no UID match, but exactly one HID match */
+		if (acpi_dev_hid_match(adev, p->hid)) {
+			p1 = p;
+			fw_bug = true;
 		}
 	}
+
+	if (p1) {
+		if (fw_bug)
+			dev_err_once(dev, FW_BUG "No matching UID in ACPI tables, but found matching HID.\n");
+		if (entry)
+			*entry = p1;
+		return p1->devid;
+	}
+
 	return -EINVAL;
 }
 
-- 
2.43.0

