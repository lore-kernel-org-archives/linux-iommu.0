Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9FD3B71AE
	for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890165; cv=none; b=DO1OVSAj3wpm09wj8F4wzogkojHNpIfRwGmsXza9en+0hQu+Rg35tsRVJ5dZyQbVzbL2tNzzj9SOCb/7JScaq1uic4LhiN7iSpZPtvUbYeeqUVbNcqeZMUtHmteTLw3yR7Js/C/Jc7h5+bA3CxfZ3ezdEAlSb706unHgtebOLGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890165; c=relaxed/simple;
	bh=sw0TWHNrZXMyx4yDOPYhfhj7BcPtnzBntl0bi224D4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aig+aWaj+s5WbE9vIUOdrAY14Rg+xBC8dZ/9jMqCnaq7OqOIj8AjmW4fuKN06nniIfW2K56v+EmwGgoS7/GksIzhBeo13GkUFkbccLIn7cGxBlWIXy2seMIjiA1MQUIKXsdSrKcLPy+9YuLuZ9w8Bi6YvajKxB5LD1H8aTZZPlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mLUQY4Ab; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mLUQY4Ab"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789890159; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=nnCjHaq5u459BP4esI2iP1Ogb+B55p2baz8QQLyndy0=;
	b=mLUQY4AbuPHH/K7ax8HZtWRTBo6x2RfhI/Q29RBtxTPZCfMrpsBXI0djUfHS7IltJFnNplEgEfCvn89xzMT/bNbykzPay7uDCf5ONQankCWNe2HwA5d44vKFfocvNFx4qb/4rS3SzV8GXePdI7aJ8jjIopVr3qP9sl4voBuRxRw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XBFJGoU_1789890155;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XBFJGoU_1789890155 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 20 Sep 2026 15:42:37 +0800
From: fangyu.yu@linux.alibaba.com
To: gsh517025@gmail.com
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	gong.shuai@sanechips.com.cn,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	joerg.roedel@amd.com,
	joro@8bytes.org,
	jroedel@suse.de,
	kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tomasz.jeznach@linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [RFC PATCH v4 08/10] iommu/riscv: Pre-enable GADE for second-stage domains 
Date: Sun, 20 Sep 2026 15:42:34 +0800
Message-Id: <20260920074234.45479-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <8572d404-8a33-4cd3-a14f-ebff7c2ac487@gmail.com>
References: <8572d404-8a33-4cd3-a14f-ebff7c2ac487@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>Hi Fangyu,
>
>On 9/20/2026 11:12 AM, fangyu.yu@linux.alibaba.com wrote:
>>>Hi Fangyu,
>>>
>>>On 9/15/2026 11:28 AM, fangyu.yu@linux.alibaba.com wrote:
>>>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>>>
>>>> Pre-enable RISCV_IOMMU_DC_TC_GADE in the device context when
>>>> attaching a second-stage domain, if the IOMMU supports AMO_HWAD.
>>>>
>>>> Software pre-populates second-stage page tables with D set, so
>>>> enabling GADE by default does not change normal behavior. When
>>>> dirty tracking is enabled, iommufd clears the pre-set D bits and
>>>> GADE becomes necessary for hardware to update the dirty bit on
>>>> write access.
>>>>
>>>> This avoids toggling GADE dynamically and keeps device context
>>>> setup consistent with second-stage domain attachment.
>>>>
>>>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>>> ---
>>>>   drivers/iommu/riscv/iommu.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>>>> index 16779877351b..f01fd4e2f840 100644
>>>> --- a/drivers/iommu/riscv/iommu.c
>>>> +++ b/drivers/iommu/riscv/iommu.c
>>>> @@ -1330,6 +1330,8 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>>>>   			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
>>>>   			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
>>>>   			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn);
>>>> +		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
>>>> +			dc.tc |= RISCV_IOMMU_DC_TC_GADE;
>>
>> Hi Shuai:
>>
>>>
>>>I might be missing something, but I don't see how the GADE bit set
>>>here reaches the hardware IOMMU DC. In riscv_iommu_iodir_update()
>>>(in patch 04/10), it looks like only the V bit is taken:
>>>
>>>	tc = READ_ONCE(dc->tc);
>>>	tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
>>>	...
>>>	WRITE_ONCE(dc->tc, tc);
>>>
>>
>> You’re right — this is a real issue.
>>
>> GADE was being set in the software-side dc, but it was not
>> propagated into the hardware DC in riscv_iommu_iodir_update().
>>
>> I have already fixed this in my local tree, and I’ll include the
>> change in the next version of the patchset:
>>      tc &= ~RISCV_IOMMU_DC_TC_GADE;
>>      tc |= new_dc->tc & RISCV_IOMMU_DC_TC_GADE;
>>      tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
>>
>
>One thought here, instead of updating individual TC bits one by one
>in riscv_iommu_iodir_update(), could we transfer all software-configurable
>bits from the incoming DC to the hardware DC in one go?
>
>Something like:
>	...
>	tc = (READ_ONCE(dc->tc) & ~GENMASK_ULL(11, 0)) |
>		 (new_dc->tc & GENMASK_ULL(11, 0));
>	...
>	WRITE_ONCE(dc->tc, tc);
>
>I’m not sure whether this could have negative side effects.
>

Hi Shuai:

That is a reasonable idea in principle.

However, TC bits may have different lifetimes and
update rules, and several features such as ATS and
PRI are still not implemented yet.

For now, I would prefer to keep the change minimal
and only handle GADE here.

Once the remaining features are in place, we can
consider a broader cleanup and unify the handling
of these bits.

Thanks,
Fangyu

>>>I saw that you mentioned you tested it on QEMU. As far as I know,
>>>mainline QEMU has not yet declared the AMO_HWAD capability. Could
>>>you clarify whether you used a modified QEMU for this test?
>>>
>>
>> I used mainline QEMU, not a modified one.
>>
>> In QEMU, I only tested the second-stage path with a
>> VM using device passthrough.
>>
>> I did not test the dirty-log related part there,
>> so that path cannot be covered there.
>>
>> That is why I noted in the TODO that I will build a
>> dedicated test case for dirty log handling later.
>
>Sorry, I missed that TODO.
>
>
>Thanks,
>Shuai
>
