Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DE7258ECC
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845641; cv=none; b=A2PEwX/pJoaIcwLh1eO7cfz7swR/zFxrruw+CGOWXMaciFPFktE/bsaa7YamNGfwC7xzM5uIpfpJZv8BxyP87PMa4/1VA8WwfxPR6SLjlrVAhKJARXAcV4NRuW0sumqRfYos/fwxc24e6wdfzbvyIw6nGJGQ5xUuxkubuh6yPSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845641; c=relaxed/simple;
	bh=r+18TqrJIjKRfxdEAVcI6vW15V+U+HszDGyCho7opzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZJlJT24lGY1gsONEgrInBwA98usG7a9nvaAF93bRrDELhBoZ2lKGycKKMZz1v3fPgi2mXN4Dra+34nkuR40pXuToju9dnNcOdFi+r8Ta4neuKjJe5d7fd2LQhqr28Ow202hIA0MbM9CtFeUkPnb712zo6Vkq0Da2Zchs99wA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=XvTVilcS; arc=none smtp.client-ip=44.202.169.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="XvTVilcS"
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id IWtwvLa8TU1JTIig2vcfrn; Tue, 11 Nov 2025 07:20:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Iig1viwIxji5HIig2vSOo0; Tue, 11 Nov 2025 07:20:30 +0000
X-Authority-Analysis: v=2.4 cv=P6s6hjAu c=1 sm=1 tr=0 ts=6912e3be
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=F0GicbU7tRTSLTLZ85HXVw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7T7KSl7uo7wA:10
 a=EVAfTSJkku-abLvejBcA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A2vBeuHXy+fLwqyZ7zf6OueolCO/uO1drbIHj1aXa5I=; b=XvTVilcSlJ9ci44nW1jbuPohsZ
	OXKntP+2bNc3+E4e0cb8s08c2Z5xS5Nfs7Q5pavEDdQsssZIyFYppPsClY+/FsBQV5fUKmdncmfmB
	efG26XAZjWqIlOE9eqg6LR3yCoyL48EYyyuI+DoSHji7sToXLoo7gfQfIH18VLYcRxJz0xKq8Cs7O
	3wUl7NxusvM1rcP478y3KO5dNOFZNWsXS9AouPVEEiOg0Gh8xryvPJlT+uDLI1csM95ieQmxvxZZq
	c8Y033Pf7dZ/z5MlFN6zLuB6aNbRWnaGh1b517Bq0SsPu8DJUKHIpuR+d/YYUruP5Szvxq2kgbAs6
	iVNSHKyQ==;
Received: from m106072098064.v4.enabler.ne.jp ([106.72.98.64]:32825 helo=[10.221.86.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vIig1-00000000iiD-07WO;
	Tue, 11 Nov 2025 01:20:29 -0600
Message-ID: <36cc3b51-601d-4412-9dca-9752e2d77a51@embeddedor.com>
Date: Tue, 11 Nov 2025 16:20:15 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] iommufd/iommufd_private.h: Avoid
 -Wflex-array-member-not-at-end warning
To: Nicolin Chen <nicolinc@nvidia.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aRHOAwpATIE0oajj@kspp> <aRIoufDcyohFWQz1@Asurada-Nvidia>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <aRIoufDcyohFWQz1@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 106.72.98.64
X-Source-L: No
X-Exim-ID: 1vIig1-00000000iiD-07WO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: m106072098064.v4.enabler.ne.jp ([10.221.86.44]) [106.72.98.64]:32825
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHbZVKZ/9vS15XDhAnXZlC7dnEv1MU0/+DqyZYzAHv8/hK/8lNXljXkxsajuZZGEYRtCGd6HrlUAyH0tqUw92XgymqHXWLTV7K6igbERY43a7B9AI6Dp
 cYzVhpbKv3/xWnD72FiqPWhuIo3dzBXzqaQI5uR3pKtXxIRCwacrreKvX2OdAp9kSjZJHiP9DupfJcQc/edOvlpeKkDa9bruKMo=



On 11/11/25 03:02, Nicolin Chen wrote:
> On Mon, Nov 10, 2025 at 08:35:31PM +0900, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Move the conflicting declaration to the end of the corresponding
>> structure. Notice that struct iommufd_vevent is a flexible
>> structure, this is a structure that contains a flexible-array
>> member.
>>
>> Fix the following warning:
>>
>> drivers/iommu/iommufd/iommufd_private.h:621:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> IIUIC, there might be data corruption due to this? If so, I think

Yep. Also, after taking a look at the commit you mention, the counted_by annotation
in struct iommufd_vevent is wrong in commit e8e1ef9b77a7 ("iommufd/viommu: Add
iommufd_viommu_report_event helper"). The counter, in this case vevent->data_len
must always be initialized before the first reference to the flexible array:

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 6f1010da221c..21d4a35538f6 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -161,8 +161,8 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
                 vevent = &veventq->lost_events_header;
                 goto out_set_header;
         }
-       memcpy(vevent->event_data, event_data, data_len);
         vevent->data_len = data_len;
+       memcpy(vevent->event_data, event_data, data_len);
         veventq->num_events++;

  out_set_header:

I'll turn this into a small patch series to fix the above issue as well.

Thanks
-Gustavo
