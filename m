Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CBD3DCD86
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933329; cv=none; b=iq1fvqfn8AY+QVQZlM+l0Lp4m6JNmah42sFKmkmnsEExMpLFSXEKgxZ/vp+NlGojSkltp9C8Sw4tdxyV8n4w+5ZuhiyTMf+yF5vSDJNtvNF2R3apWbxQXXXwbnOXwzg3whuKkZzKZSyXlES+Nj6QRnBaKl7YFyOtWvF0WpstDPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933329; c=relaxed/simple;
	bh=Mm3DudiQ0NLdWY95m4yw8nnpv5gnqKjs4IjZfwNLUi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKeNSpDo7WOEwSnxhNwMi2TbFxYBvIXrZXM40RXMuccTl4eTRlBbChQa5z4iNxbrgIVUzlS2wnT0R+MgUfWS/zk8FFWhOxqHAIg9NhHyS890MTJnB+S7MD4RG4WhzPRS6NTN4lIGajblOYdyzZ8upYgQW3EDM8Ps+k/EEDg1dW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=vbaib5bx; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="vbaib5bx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1783933306;
	bh=+AMDp3qfSOjQpwhSd+uo86N/mIuHR7Te84DEEwdSgUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=vbaib5bxKm8Qg+4urv55jllWf0SQEV5rQn4VdyK5SsYwCV4zniQ3gYL41docxxvtq
	 q+K3bwS9y0CiM51DKLYjLyEunASpVzJuX52WlDhljWxQcCuYAF/stEJK3dfkzkrLt8
	 ZCrGNkPB9fP7s9jwG5TAofuXOap7+veiXBkZI/2c=
X-QQ-mid: esmtpgz10t1783933300t20ff65bd
X-QQ-Originating-IP: KraSYcYDCvYSqFrtbcBv/SuRzAM8C5tf23JFpUaR3KY=
Received: from [127.0.0.1] ( [36.152.24.145])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jul 2026 17:01:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13213782032879603792
Message-ID: <EA5BF28D772F9B38+8825ec4a-f59f-4537-a99c-ac9e8f7eaf1c@smail.nju.edu.cn>
Date: Mon, 13 Jul 2026 17:01:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] iommu: KASAN slab-use-after-free in
 iommufd_auto_response_faults
To: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "jpb@kernel.org" <jpb@kernel.org>
References: <B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn>
 <CO1PR11MB4835631ED64FF285D915CEBB8CFA2@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <CO1PR11MB4835631ED64FF285D915CEBB8CFA2@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N4i6KJsY5wDpfB0IB8sciMFnvEY0M/RKBi2eKTxT0trk/2cGV4ze3c+s
	9XHiVxIKn1/l4nimUx3PTWEpYhbJFhDIGp++FS6W2OvbVTrrjGGBQU6GHRDHLLX9MCMEBPa
	KFXFnjPQE+gWV66nHbH2vGDzdRjHjQOE188XEbLeiVBA9ry+tVCapaFb/vJvEV2shKEOhBw
	giRFyhxtVZRk42JRt9BxEffWLedKYlBj9g20echiNHtn5y/CTE72argGQP8KuvfNC+fs2PE
	PUH09e7CZlbJz171lzBcduOcbmqE//cjXcGlgOh1IxmilGC27u9g8Zf5jGTr7M3r2tV+96w
	ZINPU6+UddcBOamxlBnc6rwN8PDAaoKZ0Uq7qDrR8sS/fDd3Cckj6RKdzqBCLmfSQM8EemV
	t4qN1nyn1fjnMEnygWpCd1B/7sRf5U9dCMIdkaQdB57SxITmfoPdLNtnqWn+GmA8DaRS1ov
	a18YE350GWH0kodvoRnGtHfOVrTSqPkH+fEjsijzIPXQFV3y+Lpwdp4glBqB/PjD/YetSC1
	F9OrNehQ4nMPiy7fTupn89nx3J7PbPgXGY9iWyZ0H6vqmRadIj+5JWdWcFGcV4A3NmZS/3A
	wcfbI2VmlTFahH6xUNL9w3l/y/+uq+LbOksdUZoO3hQTi8wypQFFsJBSwsM8hmCR6Bi5QNo
	9fXgT1sYB3uvdWMqvGVFYMif8JhEp+Wyuj8hzdqGLedxSamqAzWxpXJRvHFM0uI0/W3wzPu
	4a5nl0tV5sXHwRl/YVK80tI4m7xIgpZaV6cD0D6BxwB/549npoZugOBtyg18YqocvVLxR39
	KBVqjf8vUaddHg2lW1TfgM3Oeh0M6eom0/3Z09QtXy9C9ckbQYQ8LHGA1enQGvOhnuN5qfZ
	DXGdfOQSPj3XZGJL4i2ZxhChT1CCaqQPOsX3WZs79Od1rDdcCR2jLE9xSKYziM970KH4eEd
	SNWpQxpEyGZyzHW/axxMeTwqqhPHGuetRM9MiKfN2cf/NOG8AYyeRB4ilbAMco3T3YNtxYk
	OK8msEH4s7F3Xq0CZdxChT44/mh2yc30SDWOSVov5m9Fsm5keSoUfq1T+lOd+3k4LIQigM+
	bz58ylaR20fSX0cPWIhzJ1yLVAcE3Np5V6M7zivxWkC
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

On 2026/7/13 14:10, Tian, Kevin wrote:
>> From: Peiyang He <peiyang_he@smail.nju.edu.cn>
>> Sent: Tuesday, July 7, 2026 2:13 PM
>>
>> The analysis above goes through the iommufd selftest mock device (M). We
>> have not reproduced this on real Intel/AMD hardware, but the same lifetime
>> issue is not specific to the mock driver: Intel and AMD both have real detach
>> paths that can reach the very same iopf_queue_remove_device(). This is
>> exactly
>> what iommufd_hwpt_detach_device() triggers, via
>> iommu_detach_group_handle() /
>> iommu_detach_device_pasid(), right before it calls
>> iommufd_auto_response_faults().
> 
> yeah it's certainly a bug - it doesn't make sense to have an object sitting
> on two lists after its ownership is transferred. Suppose we should delete
> the group from iopf queue then add it to the iommufd queue in
> iommufd_fault_iopf_handler().
> 
> Can you help send a fix accordingly?

Hi Kevin,
Thanks for your reply! No problem, I will try sending a patch very soon.

Best,
Peiyang

