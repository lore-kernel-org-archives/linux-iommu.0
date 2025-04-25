Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A8418A95A
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745558014; cv=none; b=b/HvXag+yA89/E28kVo9P0Lr22Dyt4s3mXHb0fefHPZ64s82qcEV3tgCDQnpGe4E5HBoLF+m+WRxmJ5nlBJnoRsTFE918nWR5fgKo2VYZ5+ZuzDSQiJjdIXKHFaW/eMSjpPEKC3yOTSpYvvJMPJOoDcMAmJ0FPn2Ch9hWBh9fg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745558014; c=relaxed/simple;
	bh=lYQQEYJ03zn2NtyCLe7i/aEAMwNiRx8fw2/C5+8d6Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUjDrvDfMjkiuROW98nXPA5RJQ9w9pLPVfrJSVF61419n8w1hLqj6WxNaMgMYJQmv4apYt4iCKslInFaDzJhmP0F8ocQ9K5f9dsMV7HDlQ1d9I8hUE/wTQg4zyEEk+c1qzu4GBdjReNAgx4RzLx7pH6KYu676Ikr0FnkpK9dUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWG2mdcs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWG2mdcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E96C4CEE8;
	Fri, 25 Apr 2025 05:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745558014;
	bh=lYQQEYJ03zn2NtyCLe7i/aEAMwNiRx8fw2/C5+8d6Ew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FWG2mdcs60QwIyuIqs92/Rt09+0aIkq5arHhVv/Y21LJU0kLS8HPm2DF7xz1LM/oQ
	 2G0LPMzpfxF3lanGLbNIRsBPzMkFJ6WyepdgVM+LU2e4yR92QCFPhMVZZ1g61Uq1/K
	 VqJRoLSNeuhmlt4BXp/dBf7SFfvgie7RF3SbPWxKfDs6iDDrzhMAgLqi20boGJ/x5L
	 6a5nyzccrsdPMm7zjOxmIuwVNW1Ys+O+b9K/+Q5x92Z5e+Bh3K7FKbeP5XyFzCtCZi
	 0qQDeGNrhx1yeoiDHOQP/xnQMrmfFdPpj8iu0ELTS8huwlsX0ViGkYTyw45xHf0n/z
	 NN+Sff+WauJOA==
Message-ID: <94a02896-f8a2-41ec-9469-f700894c555d@kernel.org>
Date: Fri, 25 Apr 2025 00:13:32 -0500
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Allow matching ACPI HID devices without
 matching UIDs
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
 mario.limonciello@amd.com, joro@8bytes.org, will@kernel.org
Cc: Vasant.Hegde@amd.com, iommu@lists.linux.dev,
 "Blinzer, Paul" <Paul.Blinzer@amd.com>
References: <20250424045327.1898582-1-superm1@kernel.org>
 <65839537-3fc9-47cc-a22e-3672ae570f25@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <65839537-3fc9-47cc-a22e-3672ae570f25@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/2025 11:59 PM, Suthikulpanit, Suravee wrote:
> Mario,
> 
> This is actually a bug in the BIOS, and should be fixed in by the BIOS. 
> I would prefer FW BUG in the dmesg to report the issue.
> 
> As a workarond, Linux can override this using the command line option.
> 
> Suravee

+Paul

Suravee,

This was my initial inclination as well.  We actually had a test BIOS 
that lines up the SSDT and IVRS which fixes Linux but it causes problems 
outside of Linux.

Paul clarified that UID matching should be considered "optional" and 
just be used as more weight for an identifier which is how we got to 
this patch.

Thanks,

> 
> On 4/24/2025 11:53 AM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> A BIOS upgrade has changed the IVRS DTE UID for a device that no
>> longer matches the UID in the SSDT.  Checking with BIOS team, this is
>> intended behavior, however it breaks the existing logic check in
>> get_acpihid_device_id().
>>
>> In this case there is only one ACPI device on the system with that _HID
>> but the _UID mismatch.
>>
>> IVRS:
>> ```
>> [1E4h 0484 001h]               Subtable Type : F0 [Device Entry: ACPI 
>> HID Named Device]
>> [1E5h 0485 002h]                   Device ID : 0060
>> [1E7h 0487 001h] Data Setting (decoded below) : 40
>>                                      INITPass : 0
>>                                      EIntPass : 0
>>                                       NMIPass : 0
>>                                      Reserved : 0
>>                                   System MGMT : 0
>>                                    LINT0 Pass : 1
>>                                    LINT1 Pass : 0
>> [1E8h 0488 008h]                    ACPI HID : "MSFT0201"
>> [1F0h 0496 008h]                    ACPI CID : 0000000000000000
>> [1F8h 0504 001h]                  UID Format : 02
>> [1F9h 0505 001h]                  UID Length : 09
>> [1FAh 0506 009h]                         UID : "\_SB.MHSP"
>> ```
>>
>> SSDT:
>> ```
>> Device (MHSP)
>> {
>>      Name (_ADR, Zero)  // _ADR: Address
>>      Name (_HID, "MSFT0201")  // _HID: Hardware ID
>>      Name (_UID, One)  // _UID: Unique ID
>> ```
>>
>> To handle this case; while enumerating ACPI devices in 
>> get_acpihid_device_id()
>> count the number of matching ACPI devices with a matching _HID. If 
>> there is
>> exactly one _HID match then accept it even if the UID doesn't match.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/iommu/amd/iommu.c | 24 +++++++++++++++++++-----
>>   1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index b19e8c0f48fa2..f9fad07edeeb7 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -109,7 +109,8 @@ static inline int get_acpihid_device_id(struct 
>> device *dev,
>>                       struct acpihid_map_entry **entry)
>>   {
>>       struct acpi_device *adev = ACPI_COMPANION(dev);
>> -    struct acpihid_map_entry *p;
>> +    struct acpihid_map_entry *p, *p1;
>> +    int hid_count = 0;
>>       if (!adev)
>>           return -ENODEV;
>> @@ -117,12 +118,25 @@ static inline int get_acpihid_device_id(struct 
>> device *dev,
>>       list_for_each_entry(p, &acpihid_map, list) {
>>           if (acpi_dev_hid_uid_match(adev, p->hid,
>>                          p->uid[0] ? p->uid : NULL)) {
>> -            if (entry)
>> -                *entry = p;
>> -            return p->devid;
>> +            p1 = p;
>> +            hid_count = 1;
>> +            break;
>> +        }
>> +
>> +        /* If there is no UID match, but exactly one HID match, 
>> return that match */
>> +        if (acpi_dev_hid_match(adev, p->hid)) {
>> +            p1 = p;
>> +            hid_count++;
>>           }
>>       }
>> -    return -EINVAL;
>> +
>> +    if (hid_count != 1)
>> +        return -EINVAL;
>> +
>> +    if (entry)
>> +        *entry = p1;
>> +
>> +    return p1->devid;
>>   }
>>   static inline int get_device_sbdf_id(struct device *dev)
> 

