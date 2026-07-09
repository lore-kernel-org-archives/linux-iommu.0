Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBE237C103
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783566020; cv=none; b=tybk9JsgsYjTAJacIBGyZOiWJXxTz++OythvGZqxapKz/Ky5SEBKdOsKhbUPz2mI8QPi3oIVifFM5FHUbxA/2485xWlJWUGVn6tmES2+WEYyuwS4XxGl1BprKJZyKfl4tD6hUC7z71cQqpfyZwsg4UKHmVtuL9csFJrfsJcsP+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783566020; c=relaxed/simple;
	bh=wm4tw0jme+HcBEDy7KQryKW8CpbGY5FiTCVsFLTaOaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h04ESSjnQgSsG/54jB7/idHWvgeuDG3ya2P7DdcNNW40HHAykft9fmIrTLTzk33B++pT8eXfoYYCY3HE9iV80JBGBtihlIEeZoTqSgkebol7/9iWiiYDTUaWxUtZIFVK1K2Bfcn9qr0fyl8qO2iSXkbZi/fXb8yWBLj5VYBh7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=3SznuceQ; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="3SznuceQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1783565947;
	bh=T07BaYhcbEXFrDfbcvnLgawx4OnxBGGdDwVgWOzV8Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=3SznuceQAhVpdbrnnZj5u6nQjjJuHKcN8LcgKy/z8xGQyR6PXlnIT9WHtDu40BXIp
	 MFaUu+mAD3/UUmghIbFSA5/li6zTG0aOjN7GJ3DDOOkjp/gctK6wZJ8Wos7FmTmaId
	 z8STWVtQCbaF5IRxif5FTmCVZ2Wx5swZkS3ctqkE=
X-QQ-mid: zesmtpgz1t1783565938t1707c49c
X-QQ-Originating-IP: qszUKK2kKCk+6/AYzIdQXfIrVVbdG82M+OsMVJfU3uo=
Received: from [127.0.0.1] ( [36.152.24.168])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 09 Jul 2026 10:58:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3122840833428648267
Message-ID: <583AA2999FCC59F6+72894999-d86e-4b90-8a39-90fcc0176c4f@smail.nju.edu.cn>
Date: Thu, 9 Jul 2026 10:58:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] iommufd: dma-buf-backed iopt_pages wrongly reaches
 userspace GUP path and triggers lockdep warning
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
References: <E8540D7D05768C91+8b2ef227-3368-494e-909d-7b28e1489dfb@smail.nju.edu.cn>
 <20260708143609.GI118978@ziepe.ca>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <20260708143609.GI118978@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NC8a1JKFOHmWS0abYrU/5Ij1ydyqtrEu9/IOuxhtmuKJOnQ6R40RQEOc
	3CtYWh7JkoFzum83Js+zons4Z23EoiL3pw6UAWqrBPfoM9nOlHvUWrW05UZWVa67HJwsNzH
	pFUZ2BNozezuldVhE64pK3rpIt62bLI4xuGx3WQIq70MMY7xxFU294OEyJtBj+h3GDltwNI
	D9C4wjVJHgqZy/WudSC7/JOYIof7qYGofs/KthBLsv4g1KCLKdeTAIFjiXxSMv+ICCpndJk
	7aZhCp/ye8dCcycnWqLCMJUSEfpSQqIHJ1ohHqegOUTTMhrk5hvbB84rhOGuSEOKi+BG/6p
	temyQpJDbfEniUXyRwHuQhhczyfDyYtp4pRCGbdiXqQoAVTMgDDmyIeqMeVpwyQOc/HGbOX
	ABR2J2Gh9/W4qDZM3K8SeoMtUhnK9rJVjCxUCuOlx52TsSLdwD9z21LoOkgOG7tm/orHF+q
	EY0RyXUrxiI9AnpOAGkocfLIGHbLyneL0b1+98s6WRJFjqKUnxQyqrpSUqEl1JHjkH8ObD9
	XvxVHQuzxpuaFzB9P1NEXZVbUoXZsYzObZbdLT+ECwaEsOzQr2DdnI0TVRUxnwUDeJUvjx/
	x/AEOcOh+FOX5pNgZfVKIKyWTbQ9oNhZPrshCO2CniGQAq12eaCcCY5Ed5ovVOmQrD4vNnK
	jNbMdsarfYQCFYloLF4EkaMixdn6tU13habEUyGlFpvSl3NA8yndvx5yUabTxtxVvCuxQlZ
	WMe9ig8WAvlgXoYxZNBMFdjxdFl5QFwVZRJMHiUXmVgjhMzacu2RVEi3PNn1IwahmYOdqUG
	zlO0EBqtKYunbFJTgDVBVlA+MIQx2x3yoAOE7rxzpU2c+5jHl3L5KMrCtlmzCA/GTA1HZAk
	w/CLpcde2S1HD8IYnMkF+ICUBeZfmzoDERhlGQxm6zqTJIWUuDn4k5o97k4i6avhTcWmoo9
	Bu874FJlFGNsQ1ApRkQQH62aZTRUT88uOHk9X8A1Y5yK1EE1DqgWIaoMdvofAWW97DMg9rF
	pzS+Tkam2X36u46o5rl+zdYq/rHT4=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

On 2026/7/8 22:36, Jason Gunthorpe wrote:
> On Wed, Jul 08, 2026 at 06:44:25PM +0800, Peiyang He wrote:
> 
>> =============
>> Suggested fix
>> =============
>>
>> If above analysis is correct, we should add dma-buf rejection in iopt_area_add_access()
>> or/and iommufd_access_pin_pages(), similar to iopt_pages_rw_access().
> 
> Yes, this is right, it is definitely a meaningful bug that DMABUF is
> not blocked from access. Do you want to send a patch?
> 
Hi Jason,

Thanks for your reply. Yes, I will send a patch very soon.

Best,
Peiyang


