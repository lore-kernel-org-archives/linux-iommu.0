Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A36522F
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055635; cv=none; b=oOeWk0QJSE10/b47hln0MT/xwjggR+SE6rbjXobTd7fiNDyeHQk4Oq19WYvL+LxArdxNQu94xewN7bLdyrKRxv31Eg6aD3gJX8R44ri37R7jg542Y9zmrpAGP/SVl26r9S6k6wVx44gPv0WTLrgrw1dcBEe05//3aFUqqW7rOgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055635; c=relaxed/simple;
	bh=DnuykgSS8k4YLa9tPqBa2OQM/3QIufbPgMvo2bQc47g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0nHy1y7XsggIhnHu9CgDzbMmWawsqictjBQsWVvAhoUemgn+lJYmgCam6H1AyAjsCL2YgbgyqIEtFWaofiouN4AN8hRYKH/NloSRUJlwm5RF8K16uwupnOicNdh0Bg4PRXX5PGFw78t5HDuEJm3A617XCVwCdQHj1inNrYaUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2CMYGYF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2CMYGYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6204C4CEE7;
	Mon, 12 May 2025 13:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747055635;
	bh=DnuykgSS8k4YLa9tPqBa2OQM/3QIufbPgMvo2bQc47g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s2CMYGYFrZXNNJuNpz00Tf5uJ7dPUXe73HbhzHEOrBhBimDWBj/OxYNZhI+aeflig
	 uKRshUExJvpL4zsGMqA9y7a34whCkzCKy1PoXMjL9TqLJAfV+RAVUScf4lGy63rF6V
	 yQHux0tHB9zzi0EN6nUACloEACzHd7UbY2kXv7oe8BoCdRtfVZabX/4nwqedncwzqy
	 dPSqaa6uDSwMe6FwQuUd0fOOhGZ06+XbyDFbwDjMPTQqs7j8NxVzYW67d7VrAoWyy2
	 F5QL4KxyzujC3pe9GUoPKdKbilzQMiQAGBmHuszkZ7JGayjrTtBdaHfsxdHEot32j1
	 7Vkvg/HSz1tDg==
Message-ID: <49c4346c-43d0-460e-9446-66e0c2dfacfc@kernel.org>
Date: Mon, 12 May 2025 08:13:54 -0500
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: Allow matching ACPI HID devices without
 matching UIDs
To: Vasant Hegde <vasant.hegde@amd.com>, mario.limonciello@amd.com,
 joro@8bytes.org, will@kernel.org
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Paul Blinzer <Paul.Blinzer@amd.com>, iommu@lists.linux.dev
References: <20250505144451.326555-1-superm1@kernel.org>
 <0f59569b-4f92-4d2b-8f7b-05345382eff7@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <0f59569b-4f92-4d2b-8f7b-05345382eff7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/2025 12:54 AM, Vasant Hegde wrote:
> Hi Mario,
> 
> On 5/5/2025 8:14 PM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> A BIOS upgrade has changed the IVRS DTE UID for a device that no
>> longer matches the UID in the SSDT. In this case there is only
>> one ACPI device on the system with that _HID but the _UID mismatch.
>>
>> IVRS:
>> ```
>> [1E4h 0484 001h]               Subtable Type : F0 [Device Entry: ACPI HID Named Device]
>> [1E5h 0485 002h]                   Device ID : 0060
>> [1E7h 0487 001h] Data Setting (decoded below) : 40
>>                                      INITPass : 0
>>                                      EIntPass : 0
>>                                       NMIPass : 0
>>                                      Reserved : 0
>>                                   System MGMT : 0
>>                                    LINT0 Pass : 1
>>                                    LINT1 Pass : 0
>> [1E8h 0488 008h]                    ACPI HID : "MSFT0201"
>> [1F0h 0496 008h]                    ACPI CID : 0000000000000000
>> [1F8h 0504 001h]                  UID Format : 02
>> [1F9h 0505 001h]                  UID Length : 09
>> [1FAh 0506 009h]                         UID : "\_SB.MHSP"
>> ```
>>
>> SSDT:
>> ```
>> Device (MHSP)
>> {
>>      Name (_ADR, Zero)  // _ADR: Address
>>      Name (_HID, "MSFT0201")  // _HID: Hardware ID
>>      Name (_UID, One)  // _UID: Unique ID
>> ```
>>
>> To handle this case; while enumerating ACPI devices in get_acpihid_device_id()
>> count the number of matching ACPI devices with a matching _HID. If there is
>> exactly one _HID match then accept it even if the UID doesn't match. Other
>> operating systems allow this, but the current IVRS spec doesn't explicitly
>> allow or disallow it. Output 'Firmware Bug' for this case to encourage it to
>> be solved in the BIOS.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Use FW_BUG
>>   * Update commit message
>> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Cc: Vasant Hegde <Vasant.Hegde@amd.com>
>> Cc: Paul Blinzer <Paul.Blinzer@amd.com>
>> ---
>>   drivers/iommu/amd/iommu.c | 24 ++++++++++++++++++++----
>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index b19e8c0f48fa2..06f747d2f964c 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -109,7 +109,8 @@ static inline int get_acpihid_device_id(struct device *dev,
>>   					struct acpihid_map_entry **entry)
>>   {
>>   	struct acpi_device *adev = ACPI_COMPANION(dev);
>> -	struct acpihid_map_entry *p;
>> +	struct acpihid_map_entry *p, *p1;
>> +	bool fw_bug;
> 
> Initialize these variables?

Thanks - I'll make sure p1 is initialized to NULL.
> 
>>   
>>   	if (!adev)
>>   		return -ENODEV;
>> @@ -117,11 +118,26 @@ static inline int get_acpihid_device_id(struct device *dev,
>>   	list_for_each_entry(p, &acpihid_map, list) {
>>   		if (acpi_dev_hid_uid_match(adev, p->hid,
>>   					   p->uid[0] ? p->uid : NULL)) {
>> -			if (entry)
>> -				*entry = p;
>> -			return p->devid;
>> +			p1 = p;
>> +			fw_bug = false;
>> +			break;
>> +		}
>> +
>> +		/* In ase there is no UID match, but exactly one HID match */
>> +		if (acpi_dev_hid_match(adev, p->hid)) {
>> +			p1 = p;
>> +			fw_bug = true;
> 
> I am not sure why you dropped counter from v1. I think we still need HID match
> counter so that function returns -ENODEV if HID match counter > 1?
> 
> -Vasant

I was hoping to avoid more variables than necessary but be able to show 
a message.  Initially I'm tempted to add an extra case into the 
acpi_dev_hid_match() block:

if (acpi_dev_hid_match()) {
	if (fw_bug)
		return -ENODEV;
	fw_bug = true;
	p1 = p;
}

However this breaks if there are 3 HID devices because it could preclude 
a HID/UID match being the 3rd enumerated.  So I think you're right, for 
this specific case we need a counter as well to know whether to show 
fw_bug message and allow it.

I'll go back the counter used from v1.

> 
>>   		}
>>   	}
>> +
>> +	if (p1) {
>> +		if (fw_bug)
>> +			dev_err_once(dev, FW_BUG "No matching UID in ACPI tables, but found matching HID.\n");
>> +		if (entry)
>> +			*entry = p1;
>> +		return p1->devid;
>> +	}
>> +
>>   	return -EINVAL;
>>   }
>>   
> 

