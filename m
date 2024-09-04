Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A34BE6F
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725414097; cv=none; b=HonpS1HUTv+DGBNmBjWI5KkiV1cdlOs5uPnvwXtMdgMLU+O9rjABjjVdbrzWpOliynsA7Nk9PDT5VK1BWI/HTojy05fUFk7yQhMZeOvdayvBvi/Tf+he0URusgZyvMEX1hrO5ox4AfkAAzMfNjhovFQuy6QkMLTcCuzXTdwmT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725414097; c=relaxed/simple;
	bh=UnnpCwlE+so5Kv+8OWodgftABGvoZ8EJKADD4dklPFs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E1cSNO2FD+lIfmpisWgx5nWfzLez/nQmsbC6uNbC4+U31GrdWdTARWKs+x2dbLN8MEgDQlLgVUHkkWxAEacWchz6o28OQxZkh1OOJxmWw1w526PIHJffjWCTxNhETlN/SbxkHqimfkIZoVLMcvPKz+Fulb7jdQ/r9Cx5H6xHXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUF1/3BS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUF1/3BS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725414096; x=1756950096;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UnnpCwlE+so5Kv+8OWodgftABGvoZ8EJKADD4dklPFs=;
  b=XUF1/3BS6hVZtyI3ZKOLUcRozj11k17OIPO5dfRFUhr5ks6mvtk5bSkN
   CdklSPvucRbScXQo0anDSt+ilwQOnHf7AI8/IYcmawfLnxpKptkdi9fh6
   yQGg9gB70UsGw8mbMHjGKbrVJ7rBaahOmiyJ90pQtWfvW+VRT10E4y8kS
   SqJDx5xqxqfSIPi2tFxnEYPfqIAfpXXvkcOwOi1oZAwzNTHIUdMmVmUF1
   I+CrB3AUYMpXEwwc+BBBWX696NYClK0RJFf3nNeaLj8hYUILecUSBVt14
   KtQHsmwyawW7HPvmXflLceraHaH/K5cRXYzoMbcvnSCcgwLpxPYV9aevc
   w==;
X-CSE-ConnectionGUID: koDjhGlxT8ah9raZAmuBHg==
X-CSE-MsgGUID: GOWxITsBQ2qh2/g/uOrv/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23909352"
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="23909352"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 18:41:34 -0700
X-CSE-ConnectionGUID: agDQG6ANS5aB5angA94v7g==
X-CSE-MsgGUID: TrK6lBzwST6Nh/6mqu1t2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="69927690"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa005.jf.intel.com with ESMTP; 03 Sep 2024 18:41:32 -0700
Message-ID: <8ab86203-ce4e-464d-81ea-2425e769d8a1@linux.intel.com>
Date: Wed, 4 Sep 2024 09:37:35 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Klaus Jensen <its@irrelevant.dk>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Minwoo Im <minwoo.im@samsung.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 0/6] iommu: enable user space iopfs in
 non-nested and non-svm cases
To: Joel Granados <j.granados@samsung.com>
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
 <CGME20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97@eucas1p2.samsung.com>
 <20240826135955.GI3468552@ziepe.ca>
 <20240902104819.a2jto6l3tv2h5wvq@joelS2.panther.com>
 <d1e1370a-0714-4da8-b645-f56d83ab0159@linux.intel.com>
 <20240903132018.yi2xuyrp7v3npfmt@joelS2.panther.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240903132018.yi2xuyrp7v3npfmt@joelS2.panther.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 9:20 PM, Joel Granados wrote:
> On Mon, Sep 02, 2024 at 08:47:21PM +0800, Baolu Lu wrote:
>> On 2024/9/2 18:48, Joel Granados wrote:
>>>> I definitely expect PRI to work outside PASID and SVA cases, so this
>>>> is going in a good direction
>>> This touches on a detail (at least in Intel's vtd-io spec) that is not
>>> 100% clear to me. Second paragraph of section "3.4.3 Scalable Mode
>>> Address Translation" reads:
>>> "
>>>     ... Scalable-mode context-entries support both requests-without-PASID
>>>     and requests-with-PASID. However unlike legacy mode, in scalable-mode,
>>>     requests-without-PASID obtain a PASID value from the RID_PASID field of
>>>     the scalable-mode context- entry and are processed similarly to
>>>     requests-with-PASID.Implementations not supporting RID_PASID capability
>>>     (ECAP_REG.RPS is 0b), use a PASID value of 0 to perform address
>>>     translation for requests without PASID.
>>> "
>>> This basically means that a default PASID is used even though the
>>> request is without PASID. Right? Therefore "outside PASID" means with
>>> the default PASID (at least in Intels case). Right?
>> Kind of yes.
>>
>> The PCI specification defines the concept of PASID and its role in
>> transaction routing. We refer to PCI transactions with a PASID prefix as
>> "request-with-PASID" and those without a PASID prefix as "request-
>> without-PASID." Consequently, I understand 'outside PASID' to mean
>> transactions that do not have a PASID prefix.
>>
>> The VT-d specification describes how the IOMMU hardware handles request-
>> without-PASID. It uses a reserved PASID for its internal routing and
>> handling purposes. If RID_PASID is supported (ECAP_REG.RPS=1), software
>> can select its own reserved PASID. Otherwise, the IOMMU hardware will
>> use a default value of 0.
>>
> Thx for getting back to me. This generates another doubt in my head
> regarding the published capabilities from the intel IOMMU Hardware:
> 
> So ecap_pasid [1] does not have to be set in scalable-mode. Right? This
> allows hardware supporting scalable-mode to reject transactions with
> PASID whenever ecap_pasid is*NOT*  set; even though internally things
> are handled with a PASID. This question is directly related to the two
> last patches in the set.5/6 and 6/6.

Yes. And 5/6, 6/6 make sense to me. We should remove the PASID
restriction from the code once PRI is split from SVA.

Thanks,
baolu
