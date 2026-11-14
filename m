Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616864;
	b=lvdlvwrQren2S+IZVW7d7mjayIZP6H+zoYfy/5htTzzfeUAc/JHCRjUbiy5J8m/tcYIy
	 xnm3Mdz/Sf3o1/flNr2Ug9QI+mL190kjnGwHyuhEtBDCmn0iI4k7VDPItUdnl6EgIZbHJ
	 tdH7qAXFZ0JxSUhs1rDRNxomM+YSUw3Rgk55alsah4TP3A9/DeF0tqcQ4+uwyoaFAXUh0
	 tctxPJYKJ4HdwikCmjAuOjHxSWypE8JTxw3XlW+gYro5EUsJsFoRPsRYvnFD7EUPNpRmr
	 +T2w6ua3lg6aMb9ray/vcmT5rnNF06MjWmVKG6DA7dciP2eOvW33+41eMEnuHMx13WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=cKgDGjy2B74ENJy1584O13LQffNqnk/1zJsbOl8Me14=;
	b=lEk5wG6YU+7gd/E+kvHqD05pnElObB9uzRtSMzkM6fl3HNOuOrUbU4+uPn1+/EqlL4Ee
	 IUMEeYFwxF9ydHspMw+lpOFzNBOM8u08EZwHNHkXMG5MapdXentO3uwrlstx7Xrn0nSeK
	 YSzsT7dWWyOEm9pGVQ1jDk62Y+3uSgW2suI0yDO6LE3/r+zKWupRy0mKvrvRW1tb0gcFB
	 oOVoHlNm0KMe+JhtfX5UrEh0t5AoSq/BCh/GSQcOUS+lnYO+imAo7HCzeVZu3xFeoEwza
	 IvCREdAD9OjsjjOe91wGcQQ9lxkhuQdrtOpA5b9hmFNOmisUO772kBy4Dmm6i9OMHlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=CKMHRsuG;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B0D606A331
	for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 00:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5B0D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=CKMHRsuG
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91eb53957cbso41884126d6.3
        for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 16:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794616862; x=1795221662; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cKgDGjy2B74ENJy1584O13LQffNqnk/1zJsbOl8Me14=;
        b=CKMHRsuGXfsfCc73bj470ZkkOAsj0bIjS8sqjSHATiXhjf3TLu7j6qjw8Surxm15Kd
         BNJmK/O4atWsXMlLgE7Qy/H7GMjPNJh5g4uxCLTq0gu56Dar9Shev1KcoHlxw0kYgmca
         ozmiLLNUaeikdIBPRv2yu+3MKmqoOHuip/8zPV21joVx9QriQWSgWBOC6uzCKq9bWHni
         TGrD153T5485fFOGDD6WskTgg9A7HRZx7nMjlxnjI3e0QbquJhG7R1KF5rz86Mmd+7CN
         pc4lgKK4DhCATt5jQw1XP+eNEjBCvwSXRPKWn0t1wZcq1YEY9SZ0glrGQPX/l2TnFlnt
         iX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794616862; x=1795221662;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cKgDGjy2B74ENJy1584O13LQffNqnk/1zJsbOl8Me14=;
        b=qKj9ERNqZBi90ssDpKnxywun/9Muq67WXOSqc58hlptWJ+Bw2d9VdEYH3Ssq2UsbTO
         mwGNQOftjUlk9iGXIC7ns/MyXbL1zWsR/rhGJuJywfYmSB8D33aVDq8kKmqS3T7E+geo
         mjGLd8taMxL/MLzqofNBAH7H+ntZbfqrdOKi1npVvh+2C4eKhNo9CchnFS5NsNT/cOfq
         jFwL1vvgZeasRThbytEKe7tIWo408YufjR24fPC8+PR/Nluez+idb3Iuci/0iTfwhm/V
         J0n3azHO0s8sGPbt8YAQV+qHZPh7Vb1fAcIX9XhzjElbFEemIevTUYy/x54wpi8eLuN4
         w0Bw==
X-Forwarded-Encrypted: i=1; AL+hErHkFLYNH7KVmDBRVv0kjkrIGUSeQBBkJJ/u4q49gFCJdSWVC1EdORDG8CsdsAirKidbeU421Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/t6p9elPG4LiBDOZaTyMi05pdNyI6E1J3lCfsRdFVT/g1wuJdd
	y9LlqZw/YnrIWlO4J7MI0p5B5nNOP4XoOfOQ9ZBHmrhENIkQDOMU9of1zkoULz1dzyg=
X-Gm-Gg: AYBFou1+aJXafLwfFle2gIp4342B0qdJ7kdSdfr5lqpntyJwupBd8csSRg4EVjtWduN
	AJmTJbj2iHeD+/b2M/YzXdZ1pSsAC/ARITw/horONNyEmryB/2QGDKoqX8AWZL6vuHFmF+DoBmr
	UYZCGAZmx1lMKAy04Zu7qOunfAgcMWwqlLO8uDatNEEW4ZxCMHUrXU71blqup2Kp1zxpZT/ONQk
	WPfgApI14hpFIgpfd7MlFOexMylJ6I80TnmW7fAu52IcTYS3pOTFVI9L6qOJEeW6GlaaYRvJvt9
	LrPfSfGap9olo1s00uUMTJvbuTuGW3VSidbKJS4U1I/ss/kI696auUZFSSXyi2MREzuudiaFLu3
	c/0Jud9jsaotDkzS3RBQzFd2Dn+WOh+1IJrijnXC48bSFQWFc4uJybhww6IXhTn8MEI7FDvfEEm
	y+PQFaOCW5j5eMYpdnKViSiMXOmZngi176vzeLITOe5mFzl4DvHsMhbk5PHDjj1hjqBtcFrGP+e
	ij8lF2bhm9RWWtNuoxzJZ6SirdQTribLYJRgAAqLrWXEuA9Z12NMFZ5Amp1mimSxyKfrvBHKuy1
	H4k9HQ==
X-Received: by 2002:a05:622a:5a11:b0:535:a5f7:d586 with SMTP id d75a77b69052e-55ac9089b1amr63129821cf.64.1794616862516;
        Fri, 13 Nov 2026 16:41:02 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad1005027sm29936441cf.21.2026.11.13.16.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 16:41:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xS1pF-00000002PUf-1JwB;
	Fri, 13 Nov 2026 20:41:01 -0400
Date: Fri, 13 Nov 2026 20:41:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiahao Xu <xujiahao@cmss.chinamobile.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com
Subject: Re: [PATCH] iommufd: reject mapping an iommufd file into an IOAS
Message-ID: <20261114004101.GE2532299@ziepe.ca>
References: <20261112105945.285526-1-xujiahao@cmss.chinamobile.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112105945.285526-1-xujiahao@cmss.chinamobile.com>

On Thu, Nov 12, 2026 at 10:59:45AM +0800, Jiahao Xu wrote:
> iopt_map_file_pages() takes the fd passed to IOMMU_IOAS_MAP_FILE and, for
> every file that is not a dma-buf, stores a reference to it in the pages
> of the new mapping:
> 
> 	iopt_map_file_pages()
> 	  iopt_alloc_file_pages()
> 	    pages->file = get_file(file)

I've know about this for a bit but haven't got to figuring out a
solution.

This patch is not quite good enough as any fd that can hold an
iommufd, like vfio is also a problem.

Really it needs to be reversed so only a memfd or dmabuf is held, but
I don't know how to do that..

Jason
