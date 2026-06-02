Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A83E5A2D;
	Tue,  2 Jun 2026 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414976; cv=none; b=O13oBXxH3X0qGG63vU0Sgw/wMvs/4ezkndM7SgH5yc5sknVwvwbq9PDx9aUqyLa2Zd4gd/bcJ2+eKxNnQGRJu/eRv7ffrlrmpHsdj4QKFiW2NFQHyG1G2AUt7mlY6TOJjBfMd/ABaH7201oxuVK7uz6rX2dLv8RoDwHW/xOmiNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414976; c=relaxed/simple;
	bh=vAXmPnXW82ezNBAYbQ5EkhxnX42NGMZmXDhvsUCv7EI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=U3Ql6cHiiauEujk8ux7wa7UErYzUAU7zfKZvdbT5wXPmIx62l3cfQlAGyT81vvrMDpKyxxtx4A6iik84xmqEMmY8g14w1AwVZp5k0hy3BlqGC+q38UlELrCgvtEsDF6eOpJiTiIo8v3Hed8Q+4hAYkLs2wrv4dGo5w5aUdveFhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=LBhIJkhw; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="LBhIJkhw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=0ml/PbX5cofpWzn6SCgDgHb+d9iKhLQR+SUGVVILxtU=; b=LBhIJkhwU7qu3hhC+zOgqeEAQL
	amZvpO3XRHexGT+SmEXFC2qRv4GHHSH5fiN+do8nvkmUfDePwGtzJkKkCtapsMALftzZ7qW/V7NL3
	XrKyO+a4lhyCLVznvY1GgjlZkva15kJuyzYhd2FStM7Iy8D1Y2zVyQ1VG+6U3+3GjdjQssBP9YEyX
	lBJEIeOSMqE2dRS6amw1fqWNPJoOpmihIZHz32qd9t4lOt2K5rdCSjUBPeDSHXKaJKawt3hmd249Y
	PNOf1EGJQlcXLrMpfmGAW0GSOLzI1/+2Peac2II4uDy0iCAAD17fpo4PchHLWDm/2auf8hkVOFYiV
	vguQvhuQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wURGV-00000000oHb-37Ru;
	Tue, 02 Jun 2026 09:42:52 -0600
Message-ID: <c441256c-e4f6-427f-9f25-7570c991a420@deltatee.com>
Date: Tue, 2 Jun 2026 09:42:40 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Li,Rongqing" <lirongqing@baidu.com>, Robin Murphy
 <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "hch@lst.de" <hch@lst.de>
References: <20260530112852.2321-1-lirongqing@baidu.com>
 <c666e384-b365-4891-a01d-736948b995bc@deltatee.com>
 <5e2f30a4121e4672ab309460630d011b@baidu.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <5e2f30a4121e4672ab309460630d011b@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: lirongqing@baidu.com, robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com, mcgrof@kernel.org, leon@kernel.org, bhelgaas@google.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gaW9t?=
 =?UTF-8?Q?mu/dma-iommu=3A_Fix_wrong_scatterlist_length_assignment_in_P2PDMA?=
 =?UTF-8?Q?_path?=
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Hi Li,

On 2026-06-02 00:12, Li,Rongqing wrote:
>>> Fixes: a25e7962db ("PCI/P2PDMA: Refactor the p2pdma mapping helpers")
>>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>>
>> Hmm, I thought I had tested this stuff pretty thoroughly so I'm surprised I
>> missed that. But I guess seeing the users of these specifically don't allow
>> mixing with anonymous memory the vast majority of tests would only have
>> one segment.
>>
>> Can you confirm that you've reproduced and tested this and it actually fixes a
>> bug? Not just seeing something that looks strange. I have a vague feeling it
>> was intentional but looking at the code it looks wrong to me too.
>>
>> Thanks,
>>
> Cc: Christoph Hellwig
> 
> Thanks for your feedback!
> 
> This was found via code inspection. You are right that if nents == 1, or if nents > 1 but all segments happen to have the exact same length, this typo remains benign by pure coincidence.
> 
> However, for a multi-segment scatterlist with varying lengths (e.g., a short 2KB head segment followed by standard 4KB segments), sg_dma_len(s) will mistakenly assign the 2KB head length to all subsequent 4KB segments. This will inevitably lead to silent data truncation or IOMMU page faults.
> 
> Since sg_phys(s) correctly takes the current segment's address, sg_dma_len(s) should definitely use s->length to match it.
> 
> I don't have a specific P2PDMA test rig to force multi-segment lists on hand right now, but the typo and its impact on varied segment lengths seem deterministic.

Ok, yeah, I think you are correct. My tests that ran multiple segments
happened to all have the same length. But I don't have the hardware I
used at the moment so I can't test it either.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan
