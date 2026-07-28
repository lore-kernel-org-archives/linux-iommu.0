Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC5D3546D6
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216789; cv=none; b=dNiWMV6IDd7lpwqXX2XqeCGtkh/wwBVhjwIQL3CYaERsYyuV4p4jQI4Lwa+LerP+NqcLAzvTY0s4dU/M+fnMtNpfHDU1051RNqmk4RIkRfsUf86/RQWkb5w7eJ2dp9xOlFFCKBXj9QtprNVHBTyOf+GRff5MG/CAXwsjWpn4WH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216789; c=relaxed/simple;
	bh=k7ximGqrOkOEHi/l1uH/aamILqOjqUtfcpiERmgOzkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2u7pkqvuSaOfLpCrjGk2KwVaQaGwRFt4LJ1fdZrqOAuFia41zkizRn/ClSHKxgVqyPazq95M2Y1Rq2DXEn13i0EwzL9umV+Dg1OT2n3YRUTdtauyVyRSxZTcxJ8cxa31HrdEhddHPl30ekcBR3Mfh7qs9dIZurZ3AGKdprkIRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=Gmwjnilt; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="Gmwjnilt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1785216738;
	bh=wnz6WREMKOD9piLo/8eJHoYuzNdIddOrm0l0vJMjlkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=GmwjniltgD/Wi8Z6b83UIaoRQs3DX8/PAerOm3xGlmhRoeEez+9uCI3ZdBhGYIGvE
	 iLWCnE6PW3dDgLiX1piOsj++Wahv8Dkm4HKJqYTkIw4lSc2/v1dZX6B9zIOzefX33H
	 Sgy/LPiK2ylL5F9gAX2/P8/wY0ceRWjhuhbfH8Ug=
X-QQ-mid: zesmtpgz8t1785216731tc63dd207
X-QQ-Originating-IP: 4MPRxcs8UIDkQh9qxstfhXOQ4GoSBnQ7TEiaLBicJ0M=
Received: from [127.0.0.1] ( [36.152.24.148])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Jul 2026 13:32:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1698466024376348957
Message-ID: <ACFE02E91C9C4025+1b43727a-2964-4c96-8a6b-bf732a7c5620@smail.nju.edu.cn>
Date: Tue, 28 Jul 2026 13:32:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] iommufd/selftest: KASAN slab-use-after-free in
 iommu_report_device_fault
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
References: <D5E3AA41600B2056+f4e15662-bd2b-43ea-91cb-518de429e72c@smail.nju.edu.cn>
 <CO1PR11MB48353016C02FDA31BEEB274D8CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <CO1PR11MB48353016C02FDA31BEEB274D8CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MZukwSs1MH20McASkWWv3s5bROcBspLR0IWYEaIr8lgIVte3suNCe9Pw
	URmwsIo3c8OzSnpvwkr2EXIMeKRzKAFDwxSL4pMBUSG+shkhCPelNGpnq8j4R9wRfxHBznU
	SxADyziZvH6BX6dP5fNZ6uRej9dIbNqgscY7vEhf4US/TgTCdafvzRCJE4DBwVKikvYYu5Z
	7O3Y6FDECukogPSx3mYYoOprOUd46flSkEHBqwdqxq2GiMbTW/mo0GvevbVz9GwpDOcXewX
	ml3jckO2n7t8HZ6RpGHSV4WYntDbP0ppjyINzUoyU4lg1c5MRivlge1g2r1ahSy/mdBuk8Y
	QCygjq/R3q6MpzeJTsoj9mm87WeYd5TQ9xs0ngc1pnCOYQDTwE5meoATE2qP8GbgNAZ425x
	F0y4PKzz1y0OEO1xn6HKEhV1SvczI4qvQZyqXBzxJrbboAWqvi5gh+R5Stj68FfMymLCSqp
	tK/hf5B+R/Fxr/FpcB7VCW6QsKvMByw5oFKkTs6GV0iLW6Lwo70ZqAEftjpyC/h23zTkIij
	1odh2oTy5yBaX26pov8hxyXPixZEzyCrf54gL4CLERC1dc5zyec0gZrR7YTA63Qh0Xs/N5F
	i7jyHpkb7NmiVb13n5PXBNp/M7jKAM6ltOo1mhC7RfzW9f1fGjspDMoC8Dk4wfPZVT2KDKN
	D1SFPgKt4t01+NkrYd4oqXOxew6yDrJ5tc99A3jh+IZ6txuyqfyw+tz5U+4+aMAkavaG7Df
	DNYOEdG+el+UZEbEmj1bVsKaRhk+BhtRKCrGFW/HyXfpSLMvS4WL8OTvVPf2U5SXD2UV7Y3
	YsozAMVBPv5WmMnWjaZy+v4hbpT6GHlDAyCP2v5SVhGPn91nKhHWeeiMEVbqCy3tj/YDeDb
	sa4XhJ/bTcqui0jvW4SDW69qgEmpskjUn57B+kxXiQUp8KljFmYUuiqVANWy2G/YpLt4XLR
	0Yjrt6nekts0rHMfJ0t4yT66S2zGICeehhIDX0TvbGTgDEXb74ESdefkMU2nwNwskcdWJo1
	52ZBcxVwvN6hSHyhMquDvTD7Rb7mXexXA8eyDDZihdHWzSEqXU
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On 2026/7/27 17:41, Tian, Kevin wrote:
>> From: Peiyang He <peiyang_he@smail.nju.edu.cn>
>> Sent: Wednesday, July 22, 2026 5:52 PM
>>
> [...]
>  > Since iommu_attach_handle_get() explicitly says that the caller should be
>> responsible for "synchronize the call of iommu_attach_handle_get()
>> with domain attachment and detachment", maybe we shouldn't add extra
>> lifetime
>> management mechanism around iommu_attach_handle, instead we should
>> fix this at the caller side.
>>
>> Fault report can run concurrently with PASID detach and replacement, but
>> before the old attach handle is removed and freed, mockdev must block new
>> reports
>> for that PASID and wait for in-flight iommu_report_device_fault() calls to
>> finish.
>>
> 
> yes the mock driver should drain in-flight fault requests before the
> actual detachment, just like other iommu drivers do.

Hi Kevin,

Thanks for your reply. I looked into the code in more detail. Would this
approach make sense?

In iommufd_test_trigger_iopf(), call iommu_report_device_fault() under the protection
of idev->igroup->lock. Since detach and replace also require the same lock, they can
be serialized with fault reporting. This would ensure that a mock fault report either
completes before detach/replace starts, or starts only after the old handle has been removed.
Thus it should prevent the UAF.

Would this simple serialization meet the design intention of mock dev? Or would you prefer
an explicit quiesce/drain mechanism instead?

Best,
Peiyang

