Received: from rs1.nue.1e30.net (rs1.nue.1e30.net [152.53.122.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1896C28CF4A;
	Sat, 22 Aug 2026 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.122.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787405585; cv=none; b=PyThxjbAk5D4kagl0ngno7ig0/aa4qmrdOUXvCAm0bW6rBGiDM9WKaAAXRNGPH8rknT+UR/n9l+LEgml6G6eQ++SJFCkfT9ubFzIagtXl6EI+21h9rr0yL2S55mQ2ySxjhQQ77s2rjdsfeR5niwSdwbVQD9jEiSeWbcxyNzjkmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787405585; c=relaxed/simple;
	bh=2I4QipsJDSqYy6hSzoCvO93u6qMaFmKe/hCEROZoZPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxfZwR0sd8Bd5W5xaBh+D+S+HCs0VcVFP43IZwhTJBKjy+nG7lnTkiUaVO1NEtq9y4yU83ifaKnrrpsQE9E/vjYTBVdOhiCNKN7yglqcZp14bl61+EYEq07K4X3WLEXWQY5+ZNQeMOhhV5YGpg/F/ZeC8kOaMwMMmxLnLo59kRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=juch.cc; spf=pass smtp.mailfrom=juch.cc; dkim=pass (2048-bit key) header.d=juch.cc header.i=@juch.cc header.b=YtkpveJ/; arc=none smtp.client-ip=152.53.122.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=juch.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juch.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juch.cc header.i=@juch.cc header.b="YtkpveJ/"
Message-ID: <912b9d43-1205-4753-afe1-60cd149679b4@juch.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juch.cc; s=rsa-2026-06;
	t=1787405579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRqQ4b2Is81teqWqhX3PpmIpgjHjTzenSGISUDUhMu4=;
	b=YtkpveJ/WMB4rNvXBAK+gKYbW8E4X0cFhH/jajMMRvmWdmDn6KSJHm3BcJIXJK35rK+Ujo
	4lO8rGFnhyDJtxgY5UI1LVRECgOxwTHSsAfpqmw6hTt48Zpl4ZG7F7UU/VwX60buF8TP26
	N82I+VIvj1sMWydTdM14aSpAudtBkBC3aODZjdBvy1VplPVL/HkRzQnKrLijxd9QJBpPkn
	xn7KF5Ep/QMe4CwnwvbfVKED7HsdiqdM70uBohVrbNXFoeWcKEtFMq4+NWJYsC40+nGVX0
	k8ekIhu7gsUWeA7D6lk0Ll7AaMg9FZR5HpqBNsBoB/ktE0fb3r/YWdD3L8NQXA==
Date: Sat, 22 Aug 2026 15:32:58 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [REGRESSION] iommu/amd: "Fix premature break in init_iommu_one()"
 causes early boot hang
To: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Robert Richter <rrichter@amd.com>, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <07b2d390-f7a0-47e2-bc2c-eb0853acf52e@juch.cc>
 <aok4Ko0mpC4fdGPg@8bytes.org> <6a61edf7-157c-4069-a1c3-78d1138b061c@amd.com>
Content-Language: en-US
From: Andreas Juch <andreas@juch.cc>
In-Reply-To: <6a61edf7-157c-4069-a1c3-78d1138b061c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Vasant,

On 8/22/26 12:17, Vasant Hegde wrote:
> Andreas,
>
> On 8/22/2026 11:19 AM, Joerg Roedel wrote:
>> Adding Vasant.
>>
>> On Fri, Aug 21, 2026 at 11:11:07PM +0200, Andreas Juch wrote:
>>> Hello,
>>>
>>> I noticed that one of my NixOS sytems failed to boot with kernel 6.18.40.
>>> The
>>> older 6.18.39 booted fine. A full git bisect of v6.18.39..v6.18.40
>>> identified
>>> the following commit as the first bad commit:
>>>
>>>    dc266f6c4e2628576ab33042b6b2a12480220026
>>>    iommu/amd: Fix premature break in init_iommu_one()
>>>
>>> The visible symptom is a black screen immediately after systemd-boot. The
>>> machine also remains unreachable over SSH and leaves no persistent journal
>>> entry
>>> for the failed boot. A reset or power cycle is required.
> Interesting. I never imagined above fix will break some system!
>
> I assumed below dmesg is from good boot (without above patch) and did the
> analysis (code walk with below IVRS data):

Yes, that's correct, it's from the .40 kernel without commit dc266f6c.

>    - EFR advertised by IVRS is different from actual EFR (read by IOMMU MMIO
> register). Its worse because IVRS advertised few features like GT/PPR which is
> not supported by IOMMU.
>    - Without this patch we would have skipped early_iommu_features_init() so
> global EFR is zero and then init_iommu_one_late() set the EFR properly based on
> actual IOMMU capability.
>
> Only with this log, its hard to tell where exactly system failed. My guess is
> driver enabled features which are not supported (like GT/PPR) or we setup 32bit
> interrupt remapping table.
>
> I believe above patch exposed an existing bug with some other commit.
>
>
> Ideally we should properly fix late_iommu_features_init() and use actual EFRs.
> But for now lets fix the regression. Can you please try below fix?
>
> -Vasant

Thank you for investigating! I created a new branch from the v6.18.40 
tag and
applied your patch. The resulting kernel booted without any issues!

If you need any further information or testing (for a proper fix later 
on), I'd
be happy to test patches again!

Thanks again!

Andreas

>
> ---<---
>
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 69170146d442..7a5b78beb352 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1930,19 +1930,20 @@ static int __init init_iommu_one(struct amd_iommu
> *iommu, struct ivhd_header *h,
>   		else
>   			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
>
> +		if (h->efr_attr & BIT(IOMMU_IVHD_ATTR_HATDIS_SHIFT)) {
> +			pr_warn_once("Host Address Translation is not supported.\n");
> +			amd_iommu_hatdis = true;
> +		}
> +
>   		/* XT and GAM require GA mode. */
>   		if ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0) {
>   			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
> +			break;
>   		} else {
>   			if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
>   				amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
>   		}
>
> -		if (h->efr_attr & BIT(IOMMU_IVHD_ATTR_HATDIS_SHIFT)) {
> -			pr_warn_once("Host Address Translation is not supported.\n");
> -			amd_iommu_hatdis = true;
> -		}
> -
>   		early_iommu_features_init(iommu, h);
>
>   		break;
>
>
>
>>> I reverted that single commit, built the kernel again and the machine
>>> booted, so
>>> I'm quite sure that I found the right commit.
>>>
>>> System information:
>>>
>>> ASRockRack B550D4-4L
>>> BIOS P1.10 (06/28/2021)
>>>
>>> I'm no expert at all, but my research found that the following information
>>> might
>>> be relevant:
>>>
>>>    journalctl -W -b -k --no-pager | rg -i 'AMD-Vi|AMD IOMMU|IOMMU|IVRS|IVHD'
>>>    Aug 21 22:24:17 kernel: ACPI: IVRS 0x00000000BB062000 0000D0 (v02 AMD
>>> AmdTable 00000001 AMD  00000001)
>>>    Aug 21 22:24:17 kernel: ACPI: Reserving IVRS table memory at [mem
>>> 0xbb062000-0xbb0620cf]
>>>    Aug 21 22:24:17 kernel: AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
>>>    Aug 21 22:24:17 kernel: iommu: Default domain type: Translated
>>>    Aug 21 22:24:17 kernel: iommu: DMA domain TLB invalidation policy: lazy
>>> mode
>>>    Aug 21 22:24:17 kernel: pci 0000:00:01.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:00:01.2: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:00:02.0: Adding to iommu group 1
>>>    Aug 21 22:24:17 kernel: pci 0000:00:03.0: Adding to iommu group 2
>>>    Aug 21 22:24:17 kernel: pci 0000:00:04.0: Adding to iommu group 3
>>>    Aug 21 22:24:17 kernel: pci 0000:00:05.0: Adding to iommu group 4
>>>    Aug 21 22:24:17 kernel: pci 0000:00:07.0: Adding to iommu group 5
>>>    Aug 21 22:24:17 kernel: pci 0000:00:07.1: Adding to iommu group 6
>>>    Aug 21 22:24:17 kernel: pci 0000:00:08.0: Adding to iommu group 7
>>>    Aug 21 22:24:17 kernel: pci 0000:00:08.1: Adding to iommu group 8
>>>    Aug 21 22:24:17 kernel: pci 0000:00:14.0: Adding to iommu group 9
>>>    Aug 21 22:24:17 kernel: pci 0000:00:14.3: Adding to iommu group 9
>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.0: Adding to iommu group 10
>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.1: Adding to iommu group 10
>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.2: Adding to iommu group 10
>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.3: Adding to iommu group 10
>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.4: Adding to iommu group 10
>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.5: Adding to iommu group 10
>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.6: Adding to iommu group 10
>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.7: Adding to iommu group 10
>>>    Aug 21 22:24:17 kernel: pci 0000:02:00.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:02:00.1: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:02:00.2: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:20:00.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:20:01.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:20:02.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:20:03.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:20:04.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:20:08.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:20:09.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:21:00.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:22:00.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:23:00.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:24:00.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:25:00.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:29:00.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:2a:00.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:2b:00.0: Adding to iommu group 0
>>>    Aug 21 22:24:17 kernel: pci 0000:2c:00.0: Adding to iommu group 11
>>>    Aug 21 22:24:17 kernel: pci 0000:2d:00.0: Adding to iommu group 12
>>>    Aug 21 22:24:17 kernel: pci 0000:2d:00.1: Adding to iommu group 13
>>>    Aug 21 22:24:17 kernel: pci 0000:2d:00.3: Adding to iommu group 14
>>>    Aug 21 22:24:17 kernel: pci 0000:2d:00.4: Adding to iommu group 15
>>>    Aug 21 22:24:17 kernel: AMD-Vi: Extended features (0x58f77e022294881,
>>> 0x0): PreF GA GA_vAPIC
>>>    Aug 21 22:24:17 kernel: AMD-Vi: Interrupt remapping enabled
>>>
>>> And the output of the decoded IVRS table, captured by `acpidump -n IVRS -b`:
>>>
>>>    00000000  49 56 52 53 d0 00 00 00  02 e2 41 4d 44 20 20 00 |IVRS......AMD
>>> .|
>>>    00000010  41 6d 64 54 61 62 6c 65  01 00 00 00 41 4d 44 20
>>> |AmdTable....AMD |
>>>    00000020  01 00 00 00 41 30 20 00  00 00 00 00 00 00 00 00 |....A0
>>> .........|
>>>    00000030  10 b0 48 00 02 00 40 00  00 00 50 fd 00 00 00 00
>>> |..H...@...P.....|
>>>    00000040  00 00 00 00 2e 8f 04 80  03 08 00 00 04 fe ff 00
>>> |................|
>>>    00000050  43 00 ff 00 00 a5 00 00  04 ff ff 00 00 00 00 00
>>> |C...............|
>>>    00000060  48 00 00 00 00 a0 00 02  48 00 00 d7 0d a0 00 01
>>> |H.......H.......|
>>>    00000070  48 00 00 00 0e 01 00 01  11 b0 58 00 02 00 40 00
>>> |H.........X...@.|
>>>    00000080  00 00 50 fd 00 00 00 00  00 00 00 00 00 02 04 00
>>> |..P.............|
>>>    00000090  5a 4a 29 22 ef 77 8f 05  00 00 00 00 00 00 00 00
>>> |ZJ)".w..........|
>>>    000000a0  03 08 00 00 04 fe ff 00  43 00 ff 00 00 a5 00 00
>>> |........C.......|
>>>    000000b0  04 ff ff 00 00 00 00 00  48 00 00 00 00 a0 00 02
>>> |........H.......|
>>>    000000c0  48 00 00 d7 0d a0 00 01  48 00 00 00 0e 01 00 01
>>> |H.......H.......|
>>>    000000d0
>>>
>>> The relevant part (after decoding with `iasl -d ivrs.dat`):
>>>
>>>    [090h 0144 008h]                   EFR Image : 058F77EF22294A5A
>>>
>>> I'll provide any required details and test patches!
>>>
>>> Thanks for your work, it's very appreciated!
>>>
>>> Andreas
>>>

