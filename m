Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8916D34DCE0;
	Mon, 27 Apr 2026 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274259; cv=none; b=uWQfpQHHLc0p3oAlKP6Ti9/boxAybIi0DZan/w77annVxztdBER3Pp+UgOp6aSI/0E9bds6pq/fbNxa9jHuFf6e0yxwrCKRk/k8hULUABnMlOOY2iTL0qkkFXI9ziDWWMYMHukihzT0oMT2t4d2/W40o7zaBR/KL8eVX1UOY0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274259; c=relaxed/simple;
	bh=b49hu7t2dUya5gkqxXlrh7yrs+2BFABxzbC6TK/WHWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnKjBsljDlFTUTA5y2Ecb+UvEzxwNJNEpZnBK9J8uOAE97Cc4mdKXADXUghmNjFdDJ2ws4fi/eam/fhSpQtzfftUDoGcaH61ULug074h/8cLo8OLQUx62rIcc0yg9Z8B41FkR0QwKbUZRrG8vHe6KdiAbt0csJPqq2gW677hcQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGyShNIJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGyShNIJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777274257; x=1808810257;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b49hu7t2dUya5gkqxXlrh7yrs+2BFABxzbC6TK/WHWA=;
  b=AGyShNIJ1vlNVsube3Sy3g56FWU1GpehdpNLnvBOgHoAxt0mvTwU6Izr
   cO4Lxu680iPKbwNDeN53IJjYNcUvNOUGnOu8Uy1jd7oawhac9e9GhhJaV
   ysxKQa55rRM9GRKgusRf6rQTGFM+opS5KBXMMHiwUHddfmufffiqfrqQ0
   zNzbRGafMSCrTkcHvYT8ZLXkn9YlsYW3LD0Df8/0I00qqgDmTMwAvzVcy
   OEuQGBvwnKucgZyvFXsHqzgAnSAA3wTkdogE7Jzl9kQoBo8cK2xFPbcB1
   KkSnQjnqKYmZnAyjXav68HscjmBjEUSha5C7nym9kFF07FHAJctU7vik0
   A==;
X-CSE-ConnectionGUID: BgHDAv4+TO2Gob90f5Mwhg==
X-CSE-MsgGUID: OfQ5gH4RQUuyaTp1G0zxjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78267308"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="78267308"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 00:17:37 -0700
X-CSE-ConnectionGUID: ZrdvUpvgRuKVGyCtM1FTsQ==
X-CSE-MsgGUID: WCrs2hnhTha8/diOQJ+erg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="235332177"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 00:17:36 -0700
Message-ID: <d6a7f70c-5a8a-4be6-abdd-5b3decbb602a@linux.intel.com>
Date: Mon, 27 Apr 2026 15:15:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or
 a98db518dde2
To: 70sp <70sp@protonmail.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <z7Rkts0EsooZcnCjNfJaK6ursftFU8ubOkH0hcNjzxugEAwGsHLMblOdfoAx-gJzBZ-TMmeUtD7iWBngbFY5UCJCwdSmYqmCVMy-yhbirUk=@protonmail.com>
 <56ce85d5-e0b9-407c-9a86-708111a8a509@linux.intel.com>
 <C4BK-Bp_FII0EkxSHQxBS2wO-Age-UxFrp_KfmYzb8cnQ8ZndzBBIPD8S9T86wOifBP0tysQGCFtGQsBsBvG2IzIMw3jb3NF5HGbS3tsawA=@protonmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <C4BK-Bp_FII0EkxSHQxBS2wO-Age-UxFrp_KfmYzb8cnQ8ZndzBBIPD8S9T86wOifBP0tysQGCFtGQsBsBvG2IzIMw3jb3NF5HGbS3tsawA=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/14/26 17:22, 70sp wrote:
> I can confirm, that the "domain is not compatible with device" message is nowhere to be seen.
> 
> I have double checked by also adding an else statement with a different message and that one showed up several times. (by pci (iGPU) 0000:00:02.0, pcieport 0000:00:01.0 and vfio-pci (GTX 970) 0000:01:00.0, 0000:01:00.1). ret = 0.
> 

Hmm, it seems the domain is compatible with the device hardware and was
attached successfully. Perhaps you can try to check the differences
between these two domain attachments by dumping the root, context, and
PASID table entries and comparing the configurations of the success and
failure cases.

To do this, simply apply the change below with CONFIG_DMAR_DEBUG
enabled:

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d0e65bc131d..bf303cfcf2ee 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1345,6 +1345,9 @@ static int dmar_domain_attach_device(struct 
dmar_domain *domain,
         if (ret)
                 goto out_block_translation;

+       dmar_fault_dump_ptes(iommu, PCI_DEVID(info->bus, info->devfn),
+                            0, IOMMU_NO_PASID);
+
         return 0;

  out_block_translation:

Thanks,
baolu

> 
> Sent with Proton Mail secure email.
> 
> On Monday, April 13th, 2026 at 8:49 AM, Baolu Lu <baolu.lu@linux.intel.com> wrote:
> 
>> On 4/12/26 19:17, 70sp wrote:
>>> Hello,
>>>
>>> I have been dealing with a regression launching a Windows QEMU/KVM
>>> virtual machine with a GPU passed through.
>>>
>>> The issue consists of launching a QEMU/KVM VM, which gets stuck for
>>> about 2 minutes on booting with a white screen and then having NVIDIA’s
>>> code 43 in Windows.
>>>
>>> I’m certain, that the issue is not caused by anything in Windows or
>>> related software in Linux, because I tried reinstalling my whole PC
>>> including the Windows VM. I tried to reproduce the bug on an out-of-the-
>>> box Arch Linux install and the bug is still present.
>>>
>>> The first bad commit is either a98db518dde246e01ead53617dc0a30d6aaa3752
>>> or c376a3456d8bef43ec556a98c0a04c35086c2737. I don’t know for sure which
>>> one introduced it, because during bisection I had to skip
>>> a98db518dde246e01ead53617dc0a30d6aaa3752 due to it being unable to
>>> launch the virtual machine resulting in a different error (didn’t even
>>> start booting). In kernels before these commits, the VM works flawlessly.
>>>
>>> I have tested it on latest mainline kernel and the issue is still
>>> present. I have been experiencing the issue since kernel 6.13, so I just
>>> switched to the 6.12 LTS kernel instead which doesn’t have this issue.
>>>
>>> Configuration of my Linux install and hardware: https://pastebin.com/
>>> rcsyyYiK
>>> .config: https://pastebin.com/RTQCBduD
>>> dmesg errors: https://pastebin.com/84jPP81E
>>> lspci: https://pastebin.com/qi29BSWi
>>>
>>> #regzbot introduced:
>>> a98db518dde246e01ead53617dc0a30d6aaa3752..c376a3456d8bef43ec556a98c0a04c35086c2737
>>
>> Before these commits, if a device was attached to a domain that didn't
>> perfectly match the hardware's capabilities (such as address width or
>> coherency), the kernel would dynamically adjust the domain to
>> accommodate the hardware.
>>
>> Following these two commits, the driver now applies a "match or fail"
>> policy. If the domain is incompatible with the device's hardware
>> capabilities, it returns -EINVAL. This expects the caller to allocate a
>> new domain dedicated to that specific device and attempt the attachment
>> again.
>>
>> Can you please add a message line in paging_domain_compatible() to
>> verify whether it's a domain compatibility issue?
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 205debd76989..c7e1e0dfa250 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -3111,8 +3111,10 @@ int paging_domain_compatible(struct iommu_domain
>> *domain, struct device *dev)
>>                   ret =
>> paging_domain_compatible_second_stage(dmar_domain, iommu);
>>           else if (WARN_ON(true))
>>                   ret = -EINVAL;
>> -       if (ret)
>> +       if (ret) {
>> +               dev_info(dev, "domain is not compatible with device, ret
>> = %d", ret);
>>                   return ret;
>> +       }
>>
>>           if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
>>               context_copied(iommu, info->bus, info->devfn))
>>
>> Thanks,
>> baolu
>>

