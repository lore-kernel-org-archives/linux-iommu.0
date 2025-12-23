Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77610298CB7
	for <iommu@lists.linux.dev>; Tue, 23 Dec 2025 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459619; cv=none; b=KSeWEx11CmGJ9wIPood7g++UaHLz8C5KuIx5L0DjMTuUL+eQUI8rFAF+AJbN7CPL5HUUHzHSU/OkmIR5OnHnwQuAnzKyMyP1Os7fKHlUfm8Pjjm/ErgHkY/F+ycR53RYmAVaYZBWOm94iVUedqPjdG8F3/YeswSNWBogxO3SjRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459619; c=relaxed/simple;
	bh=I/Z+6ReQrt8DToJdCdYE8FXEf9dhkvJThlEwkCcvwc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eBj4GiLnFF8SePfBGuUxD4cDbP8cxHRCael0uCFEhLoS7ZRwh+gpTpbq4lWglMWFyobahkuVia/Y6aU+whOzcPKg97KbLf8FMHpe58digU2dnuKutgKMukZr9rKXXr3LozWVr1ZD6/QDsSNH+QsoBEWzLmgjU3QVjdddYxoVcf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qPdylbnQ; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qPdylbnQ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uwu0b6XCwBK0Odx1Jr2mPTth6ZOh/00lN/s+fJAt5hI=;
	b=qPdylbnQWPvFozumApJ229b/EZQer1LC74kFp6I++iWQ2ha/+/hFvDcyk3Wvci/nQpcJdArwK
	8X2Y+jTvvI4mWw+kHtCaa8OV9vbPsWK0wIlJp2yWn2bssPEY7Z5QL8pIzlWhPLVd8i9ZWLVGUlo
	9ulCikmWnBn3n7Xhy63UmWc=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4db0Pc35DPzLlVn;
	Tue, 23 Dec 2025 11:10:28 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id EA3B340086;
	Tue, 23 Dec 2025 11:13:33 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Dec 2025 11:13:33 +0800
Message-ID: <294a3819-d850-4d90-8112-da9a21a6acf1@huawei.com>
Date: Tue, 23 Dec 2025 11:13:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dma-mapping: benchmark: modify the framework to
 adapt to more map modes
To: Barry Song <21cnbao@gmail.com>
CC: <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
	<iommu@lists.linux.dev>, <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20251222153246.2220659-1-xiaqinxin@huawei.com>
 <20251222153246.2220659-2-xiaqinxin@huawei.com>
 <CAGsJ_4y_xTJJRBzvSszg0qOAX7tAahJYzLaKcTPuJg6ctJsyUg@mail.gmail.com>
 <7fd4101c-d778-468f-98be-43cccdb03b1a@huawei.com>
 <CAGsJ_4z-KRNTJsce_6pCOjEDtsiHHOh4C9K9iY1o_3--RMM-=w@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4z-KRNTJsce_6pCOjEDtsiHHOh4C9K9iY1o_3--RMM-=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/12/23 10:58:28, Barry Song <21cnbao@gmail.com> wrote:
> I’ve reviewed it many times. You are:
> 
> +               if (!mb_ops->prepare_data)
> +                       mb_ops->prepare_data(mparam);
> 
> not
>                 if (mb_ops->prepare_data)
>                         mb_ops->prepare_data(mparam);
> Am I crazy?
> 
> Thanks
> Barry
Yes, I've found the mistake...

So in my just reply, I mentioned the correct modification of the
"if (mb_ops->prepare_data)" and suggested that if you want to test it
before the next version, you can modify the patch in this way.

Sorry for the confusion

-- 
Thanks,
Qinxin

