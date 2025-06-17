Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA7F2F2345
	for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176118; cv=pass; b=T4bKUwwTmoXwdqSnbDye9C4s5Af5WJ1kJIiNOyP89FsefBiod0D15X/DFZPguU8QTIHCN0xlk8S49IQoEvxv3S2Qzbb4/g1aLklm51QlTZk405BN2YAcatbFRp4IbfXz+tZ7E9ZhgBUKZb0lQse6OINrfk8BLpV6hQqczNfAZk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176118; c=relaxed/simple;
	bh=1iEsGNV5q+xxyO0xGhH43MVOKwkFl7CUgZP+sOFZ/pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+6XZFEyegpTXY61a72yqrF+1VcGKBwb4cPrSfmq/A7HOt0+Uxxgq0WE2CRW6Oj2g8yXMJyormFAParOuYUgUigfkZsXxLj2UcQKtmlF6+BLg1up9sb7d9DHr8wHvK1p8gVRQ7C1JXvaxZLA/2TNJAAiS+q8CvXMp+KunkuPUbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=NuaGdrHJ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="NuaGdrHJ"
ARC-Seal: i=1; a=rsa-sha256; t=1750176100; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mmO+Alr6kQQXRa0SJVWm+b4p0d0PO0kWFXmacsiV+zFpHlrkpTljUui27K7SbsVyZgK4xBfJ4OCyi3iwRj9kUhB5qC79j9nbvoM/2RX+/i58sFtPCHUCiX0u3xKGT8WIbUtW8ZCWip6ZB1XkD1YgYEdUQXFZfwOPXYU9lhmjflo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750176100; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TorOeLYGo8DxParn34xnnfB8pnXI12Opq9BZvAUKlQQ=; 
	b=aWh0O/5Tp5bLOSObnkuu0O1sB9gk6qA7kSaBWNOsuSyTbh3x+NecyXnJnmUEBgalYAjlcu3Uuz49nHTb4sw3bMi16+12UqfpW8NsQ5HesSJMlvU7r8S6UQfABdF358zNuu9WFbV5kRGcTnMBZqzJbJPXRtaaM5ExmbpCKPkxzAM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750176100;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TorOeLYGo8DxParn34xnnfB8pnXI12Opq9BZvAUKlQQ=;
	b=NuaGdrHJ97ZwgdVUJeSfzo9qAbE9wjsfOfrx9UNJAr8B6dPp/vpZcyAMuHn/kxU+
	/p5m4mr1GDQ3Xze8r1Oi4Taa18BZ89QToQy3oCelUgnt0PfJqr1ONqcr+9MSs4yRlud
	x36VTLbw3MZJVMXnA3CKGicFf24NRPHO/7xgsAbs=
Received: by mx.zohomail.com with SMTPS id 1750176095913785.9876014183155;
	Tue, 17 Jun 2025 09:01:35 -0700 (PDT)
Message-ID: <30a48107-8e98-42dd-a5a7-9c87c9eb538d@collabora.com>
Date: Tue, 17 Jun 2025 18:01:31 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] media: verisilicon: Flush IOMMU before decoding a
 frame
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 nicolas.dufresne@collabora.com, p.zabel@pengutronix.de, mchehab@kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20250616145607.116639-1-benjamin.gaignard@collabora.com>
 <20250616145607.116639-6-benjamin.gaignard@collabora.com>
 <20250617155822.GE1376515@ziepe.ca>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20250617155822.GE1376515@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 17/06/2025 à 17:58, Jason Gunthorpe a écrit :
> On Mon, Jun 16, 2025 at 04:55:53PM +0200, Benjamin Gaignard wrote:
>> Flush the IOMMU mapping before decoding a frame to ensure that all memory
>> translations are properly applied.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   drivers/media/platform/verisilicon/hantro_drv.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
> This is a really big red flag.
>
> iommu translations are supposed to be controlled by the iommu driver
> and should be flushed as part of the iommu map/unmap flows. It should
> never be necessary to do something like this.

I have redone tests without this patch and the decode is perform correctly.
I will drop it in the next version.
I think I have fix the reference frame management in the driver so it becomes
useless.

Benjamin

>
> Jason
