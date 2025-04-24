Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772A4F510
	for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 04:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745470433; cv=none; b=g5NGH81eDiom2Ta40BiHcxvZwwXJISJWMOp+jihPFKKgVqVCQoSXQQUoGvmANXAC+2U2RcbAq27+/jitxbCJ1NjUoyHGNQaGwv2WqwpDpAvmUrZahbWzZ3fSzda7gBJ51NiYdt0+cHXkOiB7E5cKF8jkCns8rht/JCzP6QxXcW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745470433; c=relaxed/simple;
	bh=sTm+TuKpsLNFy2mUQha4KHtTjcIP9zNusc5AQpMF918=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abL2UKUKzNTGBY08vpU4VbgMpOqugJF9n5POpf2thwD1224NuqO3Wep0h5cgjkwJaPUdksqt7oDHtSnkMuQ1iRi8xRXnzC7Sm7gqTXABng2RuGoPjft7n1hSchJg04JYYRBnxRUHMsSjEMs46Ex8Mrbx9bh0shoZCQKFC2IT3SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6gzMLoT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6gzMLoT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5261FC4CEEA;
	Thu, 24 Apr 2025 04:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745470432;
	bh=sTm+TuKpsLNFy2mUQha4KHtTjcIP9zNusc5AQpMF918=;
	h=From:To:Cc:Subject:Date:From;
	b=u6gzMLoTpwfPhDhq2okar5J2qOYIyfRlr4FY4Omw/TI0uAHAQr4cgnu51qHO/ASnL
	 MeZrz9VwG9ADA5GVm1VNldZDmwNU9ybyqsh66g0VNdjo5IgW+dDl5Bjx3YGBDpJoiL
	 qPvqMz6qmDesIzDduivFVO0qS1cFIDvPbE0ZJ9IrVZ7b+NkhqACgnx6Gc6+ywEEg2w
	 SSjI0WtZGnZJ18GaebwBNPvah0QpbAaM9PUtb2/3Eh5b45nDoNeILdROaBmv/4jSiU
	 cgni5DQvgpaOI+uoSwOlWDopAmpJG+BLaf/xFQUdWin4UwkhWEK7BbQa2LVkvuuW+Y
	 SovpmHajeL8+g==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	joro@8bytes.org,
	will@kernel.org
Cc: Vasant.Hegde@amd.com,
	iommu@lists.linux.dev
Subject: [PATCH] iommu/amd: Allow matching ACPI HID devices without matching UIDs
Date: Wed, 23 Apr 2025 23:53:26 -0500
Message-ID: <20250424045327.1898582-1-superm1@kernel.org>
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
longer matches the UID in the SSDT.  Checking with BIOS team, this is
intended behavior, however it breaks the existing logic check in
get_acpihid_device_id().

In this case there is only one ACPI device on the system with that _HID
but the _UID mismatch.

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
exactly one _HID match then accept it even if the UID doesn't match.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/iommu/amd/iommu.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b19e8c0f48fa2..f9fad07edeeb7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -109,7 +109,8 @@ static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
-	struct acpihid_map_entry *p;
+	struct acpihid_map_entry *p, *p1;
+	int hid_count = 0;
 
 	if (!adev)
 		return -ENODEV;
@@ -117,12 +118,25 @@ static inline int get_acpihid_device_id(struct device *dev,
 	list_for_each_entry(p, &acpihid_map, list) {
 		if (acpi_dev_hid_uid_match(adev, p->hid,
 					   p->uid[0] ? p->uid : NULL)) {
-			if (entry)
-				*entry = p;
-			return p->devid;
+			p1 = p;
+			hid_count = 1;
+			break;
+		}
+
+		/* If there is no UID match, but exactly one HID match, return that match */
+		if (acpi_dev_hid_match(adev, p->hid)) {
+			p1 = p;
+			hid_count++;
 		}
 	}
-	return -EINVAL;
+
+	if (hid_count != 1)
+		return -EINVAL;
+
+	if (entry)
+		*entry = p1;
+
+	return p1->devid;
 }
 
 static inline int get_device_sbdf_id(struct device *dev)
-- 
2.43.0

