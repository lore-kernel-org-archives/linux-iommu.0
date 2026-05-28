Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB76313550;
	Thu, 28 May 2026 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948607; cv=none; b=sJhlQsIES1znwGH6pY0sYKSeehu8RkYFM/GTKnVasWq8kzOkho5OKOma4KJTVXwWE9SWoyG1de5CCjAxIBxCWTTg7c6hmHF/SKU6wX3wWQQ9sbwO4iTRHEP2Dwi4gl8d134Ex5KC8mJkHf6ageHE8QHpUHJRkULHkLl8H9XmF7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948607; c=relaxed/simple;
	bh=fVaHuTW8d467YcfkPblgYHpsyrC0RvuaO2guMO2TPYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/BvDn1MBKs261F9JoZaV/XOkCEAM9Zm4Bt087aRlpYtFsvhgfWCVo8e9C0sCixoPmwWKOr4aV06zH6QWt0RQHEzWgKy693ysj4SuLqLOYDC1nq3SSf2Ceq3gHnXMOIvZ/bERnw1LAjkzP1ijzxVQmrBNYEUAT66vOwRSF4Qr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NT0EAz3l; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NT0EAz3l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779948605; x=1811484605;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fVaHuTW8d467YcfkPblgYHpsyrC0RvuaO2guMO2TPYM=;
  b=NT0EAz3lZMa/hgm7qCjYTkjaitUnRAd1RV0NaFcOsJRarg4LqrvZ4vbC
   T5HPMAouU4P5oFdoeZVV4vNf2moSvbHtbWrcQ9FeKvCllPWH6JnmJoLLv
   TjOusqeRGEaR4Q3cUnDkpbCyeQkrR3GDMg6PYyVZFTD4h5S65M77MR4mL
   q5/pqX5eWOw0zj44yZ/Sj45Z4l1qeyuju+kPnXg+Zbps/lYl1K/CG2oHT
   9sEKvPAEGBEJzeR/oxodewc3aaZ0cM0U4RbY1q/FthE3kU+DUTpSYhflq
   xYAFrBsNIzXFgo/1Fpvb2HPqestgUDx1ghHXdl0lTWDnwk3+5jqQUH+1z
   A==;
X-CSE-ConnectionGUID: oRWE8f/xSiuzhlcz+tpshg==
X-CSE-MsgGUID: ii5JESO7Q/mDfQ1OKlS0bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80512459"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80512459"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:10:05 -0700
X-CSE-ConnectionGUID: BfavsKTDR2G1EdVf1RqJRQ==
X-CSE-MsgGUID: mIH4ex+cT+evy/Qoo5QfKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="238036948"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:10:03 -0700
Message-ID: <82662a17-f9e2-46dd-9881-792412c1dc50@linux.intel.com>
Date: Thu, 28 May 2026 14:09:19 +0800
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
 <d6a7f70c-5a8a-4be6-abdd-5b3decbb602a@linux.intel.com>
 <7ec374cb-9a0a-4e30-8410-3a028e46cacd@linux.intel.com>
 <5bVscg7a2_H1PPW3HmVtrYv_Xwtti2hzjD065W4OdwsD9rC2gw7sGVEg-2U596VZn8O2LAEfhWeZklRk63ymqNW9220R6R_jjif7BaWol9o=@protonmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5bVscg7a2_H1PPW3HmVtrYv_Xwtti2hzjD065W4OdwsD9rC2gw7sGVEg-2U596VZn8O2LAEfhWeZklRk63ymqNW9220R6R_jjif7BaWol9o=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/26/26 03:57, 70sp wrote:
>> Have you tried this patch? It dumps the context and PASID table entries
>> after a domain is attached to the device. Hopefully, you can find some
>> clues by comparing the good and bad kernels.
>>
>> Thanks,
>> baolu
> 
> https://lore.kernel.org/linux-iommu/uaUIyysjsnLHVLladjVXkuU63CTRoEzcw3BdlDX2cdkt8T82i0AX79VQAJo08uMKvpnn20xyK0Pu2PrtyMV3hmSgcwutWhV14fgjyTW3aiQ=@protonmail.com/
> 
> I did, as I already wrote before. I looked through everything I could and was related, but I just haven't found anything. I don't know where else to look than I already did and documented before. If you have any idea where should I look for something, I will do so.

I’m having trouble accessing the links you provided.

As you noted, the first bad commit is either commit a98db518dde2
("iommu/vt-d: Enhance compatibility check for paging domain attach") or
commit c376a3456d8b ("iommu/vt-d: Remove domain_update_iommu_cap()").
These commits refactored the code to move hardware compatibility checks
into a helper, enforcing a policy where domain attachment fails if the
domain is incompatible with the hardware.

You confirmed that the domain attachment itself still succeeds both with
and without these commits. This suggests that the refactoring hasn't
altered the final result of the attachment process.

I am now investigating whether these changes affect the context or PASID
table entries. If the entries remain identical regardless of these
patches, it would indicate that these commits have no functional impact
on the hardware state. However, if there is a difference, we can then
analyze how that relates to the regression.

Thanks,
baolu
