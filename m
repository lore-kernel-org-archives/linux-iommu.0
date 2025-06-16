Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51350274652
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067606; cv=none; b=nYz8DS9Yy2uYrv1bhvUtA3Cx6jDAn/U5ifaFl37VRFJHl5G8wvi12sCizZSRrTgIunE3bo6gbxNqM13piCDVSovBk90Lfd93Tk0f19b1SUbP4Z+4AfloDojMFIBh/ywUrLxdfjtBXbMiucVtbMAF0QOZ5ESJebFYOggm1Vix0lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067606; c=relaxed/simple;
	bh=4cv8uE6pGypsCSgH3uyNQBvUvH0nntwDkgEVp1CQBYI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZK8CArAGKWKViy5bRDgzMU8/ybwxGbH2XjdgFBL8Y00sMxq8pQcOdKGysyS5l9HXg+gt+BwsjWk9LTKDAsxcz129CrrIZ0q4hYImuDu7kUrcUxhwBgOKtF9LAxiWRgTDz7o6yM+vTKtoWVeHC3mNOWat/x2GGcRa04K9CYfkpOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bLQHk0HX0z6L5JK;
	Mon, 16 Jun 2025 17:51:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DC218140119;
	Mon, 16 Jun 2025 17:53:20 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Jun
 2025 11:53:20 +0200
Date: Mon, 16 Jun 2025 10:53:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
CC: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [RESEND PATCH v4 1/4] dma-mapping: benchmark: Add padding to
 ensure uABI remained consistent
Message-ID: <20250616105318.00001132@huawei.com>
In-Reply-To: <20250614143454.2927363-2-xiaqinxin@huawei.com>
References: <20250614143454.2927363-1-xiaqinxin@huawei.com>
	<20250614143454.2927363-2-xiaqinxin@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 14 Jun 2025 22:34:51 +0800
Qinxin Xia <xiaqinxin@huawei.com> wrote:

> The padding field in the structure was previously reserved to
> maintain a stable interface for potential new fields, ensuring
> compatibility with user-space shared data structures.
> However,it was accidentally removed by tiantao in a prior commit,
> which may lead to incompatibility between user space and the kernel.
> 
> This patch reinstates the padding to restore the original structure
> layout and preserve compatibility.
> 
> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")
> Cc: stable@vger.kernel.org
> Acked-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

FWIW I checked the patch above indeed accidentally dropped the padding and the structure
is copied to userspace so this fix is correct.  Given it's not in a uapi header this
only really affects the selftest I think this is mostly a case of there possibly being
out of tree tools with a local copy of this structure definition.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
