Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BBD18C02E
	for <iommu@lists.linux.dev>; Sat, 17 Jan 2026 04:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624327; cv=none; b=ESrD4cM9fn70RGrzx/X0igXhXbw8ny3v0rB1kqkeNjv8i1gebPC/hOTLp2jGcQuE6m8qBK1BHzbFLrHvb9n0mAaOZEvNGyUrVRNJOAHMB4+EWXKsBvOBghufgutbEsh0ND5irxULY0oiUf/mi0UVGgAEuG61vBE27vatM8XZGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624327; c=relaxed/simple;
	bh=CdHaO2ownfXa7ipANj7/qmEGP2giRrtaZe2Doei12yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfGW9NVQ3VWtys2x9DZijxM+mooBtOTk5akSmt92PE0NMXLKQizCYmu198O9Acm+4FHYPbrLnzYFATlrlAD0sKJTX5JhO6pVlp9nVGqwYGAt54p0akJxL7RfoDpaeQK4pOQuBAYtKCSafWMGGmbkihgB9qehzwX9dGHakaSMJpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=On5du+N+; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="On5du+N+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768624316; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=S2OHuJi/yz/Cs1m5SZ1eWya83DfuWdjDDqbxTmTV8Og=;
	b=On5du+N+TG8XCKddUYVYKZQKr2qGoyfs3IuFjx4mMnA/Cmd+6l+GhxSZvhN2ug608azSoST5T4GZVLxiHI/wlj24THvsAJNvVM3jAMvPm4NOq90yR1Oiwa6g5VRQbGIrzwDWLNcjhRyNiiX7THt548wGUa+rumSZqbTOXXWlUN8=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WxC61S8_1768624314 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 17 Jan 2026 12:31:56 +0800
From: fangyu.yu@linux.alibaba.com
To: andrew.jones@oss.qualcomm.com
Cc: ajones@ventanamicro.com,
	alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	will@kernel.org
Subject: Re: Re: [PATCH] iommu/riscv: Add IOTINVAL after updating DDT/PDT entries 
Date: Sat, 17 Jan 2026 12:31:49 +0800
Message-Id: <20260117043149.76084-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <q2jjixx6imiwdwlxiu4cnh6nghnueivjge5d4jscor5q6yx2el@lxujpebn3nsx>
References: <q2jjixx6imiwdwlxiu4cnh6nghnueivjge5d4jscor5q6yx2el@lxujpebn3nsx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

>On Fri, Jan 16, 2026 at 02:12:06PM -0600, Andrew Jones wrote:
>...
>> > @@ -1055,6 +1135,11 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>> >  		/* Invalidate device context after update */
>> >  		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
>> >  		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
>> > +		/*
>> > +		 * For now, the SVA and PASID features have not yet been merged, the
>> > +		 * default configuration is inval_pdt=false and pc=NULL.
>> > +		 */
>> > +		riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc, NULL);
>
>Shouldn't this iotinval come after the cmd-send below?

Yes, that's a typo on my side.
I’ll fix in v2.
>
>> >  		riscv_iommu_cmd_send(iommu, &cmd);
>> >  	}
>> >  
>> > -- 
>> > 2.50.1
>> >
>
>Thanks,
>drew
>
Thanks,
Fangyu
