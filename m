Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2058225178A
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071607; cv=none; b=nVY99kdnKOsg/C4glraOCmn20xK2eJrgGhG2G3rxTHoOX5/dge7AsbxNV7bvX2hvCTs9oDMB1dpkiovWA9r51P1QcaYuUa5XUB4cA+nHxgOiFzW6fjUXHBRqgIKInuRBV+VYxsYiBqJqPH75SH2MpJRFX/3uPr/J8IbBvVFHYUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071607; c=relaxed/simple;
	bh=5eTfih0jX1oO0MA3ybx8OgSU1+VEbN/dTMUvtptLCIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYgCu5xgC49X9Ra/vimyk20AnCRlnckdyjtM4v7A86ke55X+0Bgoiiwi5L3KVX6Keh619kl98pp4f6sjGgXwWyIe5FcfmbplDpe2Uvx3o2DDQgjsQMCxrhkhsEe21F5+bh42YynzJQmBuGbiy1rFoClQizxnf+lNETOVfetmF34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Apqxu0z6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Apqxu0z6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41A5C4CEE7;
	Mon, 12 May 2025 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747071606;
	bh=5eTfih0jX1oO0MA3ybx8OgSU1+VEbN/dTMUvtptLCIc=;
	h=From:To:Cc:Subject:Date:From;
	b=Apqxu0z67O9v+2F4OMzJpGTMK05t0f4msZF31J18oRurzukzKYHWfUvG6Une7XXY7
	 tqvSwfzRxQfX1CInRvkHIBhjs9k77pVgDAviDBQdBfQP0W3j1y0kG0mS6NDvfaynbQ
	 HLjbXMh5O/pEA6knUsryaPObzzuGgOOgqds/rW3uUUieie6tj0Qthge/+x7pbu+r0g
	 o6AkQKqECMiGVe54L6LWFSEHpgTEjkW0LfV+uYqMNQy8bDmsKpnAlj1JjDLGX12IA0
	 5p7MqWc542wU8G+YQ6GB5UDOE9VhzVhhVzTIOPHvmLemUkQJflrAHjE5ZLzf7xxqXD
	 uSdx0xQOnX1qA==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	joro@8bytes.org,
	will@kernel.org
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <Vasant.Hegde@amd.com>,
	Paul Blinzer <Paul.Blinzer@amd.com>,
	iommu@lists.linux.dev
Subject: [PATCH v3] iommu/amd: Allow matching ACPI HID devices without matching UIDs
Date: Mon, 12 May 2025 12:30:32 -0500
Message-ID: <20250512173129.1274275-1-superm1@kernel.org>
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
              Subtable Type : F0 [Device Entry: ACPI HID Named Device]
                  Device ID : 0060
Data Setting (decoded below) : 40
                 INITPass : 0
                 EIntPass : 0
                 NMIPass : 0
                 Reserved : 0
                 System MGMT : 0
                 LINT0 Pass : 1
                 LINT1 Pass : 0
                   ACPI HID : "MSFT0201"
                   ACPI CID : 0000000000000000
                 UID Format : 02
                 UID Length : 09
                        UID : "\_SB.MHSP"
```

SSDT:
```
Device (MHSP)
{
    Name (_ADR, Zero)  // _ADR: Address
    Name (_HID, "MSFT0201")  // _HID: Hardware ID
    Name (_UID, One)  // _UID: Unique ID
```

To handle this case; while enumerating ACPI devices in
get_acpihid_device_id() count the number of matching ACPI devices with
a matching _HID. If there is exactly one _HID match then accept it even
if the UID doesn't match. Other operating systems allow this, but the
current IVRS spec leaves some ambiguity whether to allow or disallow it.
This should be clarified in future revisions of the spec. Output
'Firmware Bug' for this case to encourage it to be solved in the BIOS.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Count HID matches as well (cover # HID w/o UID > 2)
 * Drop level of indentation with early bail on error
 * Show number of matches in error message
 * Adjust commit message
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Vasant Hegde <Vasant.Hegde@amd.com>
Cc: Paul Blinzer <Paul.Blinzer@amd.com>
---
 drivers/iommu/amd/iommu.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b19e8c0f48fa2..0c909d0d59bfd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -109,7 +109,9 @@ static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
-	struct acpihid_map_entry *p;
+	struct acpihid_map_entry *p, *p1 = NULL;
+	int hid_count = 0;
+	bool fw_bug;
 
 	if (!adev)
 		return -ENODEV;
@@ -117,12 +119,33 @@ static inline int get_acpihid_device_id(struct device *dev,
 	list_for_each_entry(p, &acpihid_map, list) {
 		if (acpi_dev_hid_uid_match(adev, p->hid,
 					   p->uid[0] ? p->uid : NULL)) {
-			if (entry)
-				*entry = p;
-			return p->devid;
+			p1 = p;
+			fw_bug = false;
+			hid_count = 1;
+			break;
+		}
+
+		/*
+		 * Count HID matches w/o UID, raise FW_BUG but allow exactly one match
+		 */
+		if (acpi_dev_hid_match(adev, p->hid)) {
+			p1 = p;
+			hid_count++;
+			fw_bug = true;
 		}
 	}
-	return -EINVAL;
+
+	if (!p1)
+		return -EINVAL;
+	if (fw_bug)
+		dev_err_once(dev, FW_BUG "No ACPI device matched UID, but %d device%s matched HID.\n",
+			     hid_count, hid_count > 1 ? "s" : "");
+	if (hid_count > 1)
+		return -EINVAL;
+	if (entry)
+		*entry = p1;
+
+	return p1->devid;
 }
 
 static inline int get_device_sbdf_id(struct device *dev)
-- 
2.43.0

