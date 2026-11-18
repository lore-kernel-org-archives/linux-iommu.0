Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794982751;
	b=WmVRggZomMIsymo0hZA14x2PwPknnwPg3sjlQXwsqP9k3O533XAzuACk4WtgMt4yiEQu
	 yfPhZ+qyyZ9U3RgFRsw9kt83ekYoONhJGUDH3Y+T8j6nUrKKMbbfRr5La7exQuH76CPYC
	 z/cgifQCwQftIpe06zbL5FmbUhvf7Fdua34H578o/B+taQXwA8QxksXk6VO0dK2JZGTXZ
	 VHB7fV6nrMFvjc5dO30eK+55BRCsmj1XEDT79xVBTYp9iLVM7JfjZGnI1hkn/GT7/rZf9
	 /3BysbwbKh8TZ3uSUfrJkocma2nxwu1iG9h2SizIcHC4Ers+kzo2Z7MzKp9sSgvIigQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982751;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=6gz7Nx7ggXBiPpxUu/CpbITekAUnvYqcbi8BBpYRjls=;
	b=rWwDwTOC97tcsTA3aQ38EGt2F/mip6RxlAli8ydaB/rrhRHBEVbN0YtVIbeDCOM6p3Nw
	 ylH0k4qUlTEsLUDVeXncNQxSzNwSoDtn+241n4zcdCe5RZrFny3saBgVZLsoUW94AwM4g
	 x1hdsnMvwUQ0l8buC6vKSNKP1NJpwE8imQKMgYLuEzEDejDleP4FMQbiVVDjQquGLKGcY
	 hX5Pe5iDjPE5HJG1CHCPgwrm5XMiVYN8u4mQ8V4hs6GxkAQJNlqpZik8UwYOtwM3ByD80
	 gWBY/E62tRFuF020maqvJI6xIgECPAabwoVEIJMLV7uYLexDFjVhzYpwxv5e60FOGZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B129E606A325
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 06:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B129E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jTryt410jz6G4LK;
	Wed, 18 Nov 2026 14:19:02 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl1.zte.com.cn with SMTP id 6AI6Ivh0085817;
	Wed, 18 Nov 2026 14:18:57 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Wed, 18 Nov 2026 14:18:59 +0800
X-Zmail-TransId: 3e816afd434602e-b02db
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: fangyu.yu@linux.alibaba.com
Cc: alex@ghiti.fr, andrew.jones@linux.dev, anup@brainfault.org,
        aou@eecs.berkeley.edu, atish.patra@linux.dev, baolu.lu@linux.intel.com,
        gong.shuai@sanechips.com.cn, guoren@kernel.org, iommu@lists.linux.dev,
        jgg@nvidia.com, jgg@ziepe.ca, joerg.roedel@amd.com, joro@8bytes.org,
        jroedel@suse.de, kevin.tian@intel.com, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com,
        skhawaja@google.com, tanchi25@mails.ucas.ac.cn,
        tomasz.jeznach@linux.dev, vasant.hegde@amd.com, will@kernel.org,
        zong.li@sifive.com
Subject: Re: [PATCH v7 00/10] iommu/riscv: Add hardware dirty tracking for second-stage domains
Date: Wed, 18 Nov 2026 14:18:47 +0800
Message-ID: <20261118061848.184844-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103120236.53474-1-fangyu.yu@linux.alibaba.com>
References: <20261103120236.53474-1-fangyu.yu@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 6AI6Ivh0085817
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 18 Nov 2026 14:19:02 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFD4356.003/4jTryt410jz6G4LK

Hi Fangyu,

We should add "select IOMMUFD_DRIVER if IOMMUFD" in
drivers/iommu/riscv/Kconfig to enable IOMMU_HWPT_GET_DIRTY_BITMAP,
otherwise it always returns -EOPNOTSUPP. I guess it belongs in the dirty
tracking patch.

Thanks,
Shuai
