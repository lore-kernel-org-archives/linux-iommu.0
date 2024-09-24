Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BD47406D
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159266; cv=none; b=jjV7PPqlQ+eAo24ZKLKUEBjsMMlPR21wbj8Mk0L5/wDjml2PgJhForra4ttToRhmVvfkRPSHNSOAd1KkqUYoJvApa6Nhh4X6fNgp4Vi+xFtMy3hT4O3yFNyfn3JGEdeUpcdXYz1ISgLrgCDsmu+0R0EVsGZbkTjTQmjfJdG1P2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159266; c=relaxed/simple;
	bh=Fq1eeBVCVo8skENTGGXSVFjvxg6ebjriCPrvVo2SiL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMjauRkAUJdV/Dx1g2AGJ0XHtFw1enGCbETiYAkM8pEADDRme1T3rsNoXHTgnBRyyZIPpD9Tra2BrtK+txr01EOOIsaurPWwsMB3xO5RQHDGkDVsS6WX0ITvgY1iwv9NKwZi8DUGjWWFJ92FpcZwbftEbfwDajU+meCi1E22e1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z+HKR/rk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+HKR/rk"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db54269325so3906821a12.2
        for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 23:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727159264; x=1727764064; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq1eeBVCVo8skENTGGXSVFjvxg6ebjriCPrvVo2SiL0=;
        b=Z+HKR/rkRerRagwtO/BVqTbssCjhBqEupeQfOMszgtczMbHdqdjX4kdFH94z7pgn8A
         6ecRgqFg6smTDXx8EwI3nCi0yU5ZU0V6zO43EdPhhvreTGHaRR2jRwvH/qaeKnV8T+rJ
         iEFILJ9y+fnQSwKyxCyk2NfxW30o5x9fvdUPRwch7SYgZ8OoJk/uhlWTMXml/EgWWTjv
         Oe/sQtFXF4TQU9xGpL3ZCm8DX9O2mF08jZZWb1VjbfBjrb2c+1lqgbQOySZC+wc+ytZ6
         1/xQHnQXfRRRorWj9o8Sbw7qkJnxkk0xTyeJvV14u8fhSDuRR/aTpOh45OJFpvQYYTCx
         GOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727159264; x=1727764064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fq1eeBVCVo8skENTGGXSVFjvxg6ebjriCPrvVo2SiL0=;
        b=GDhHLBTPUxcVYwfPguVDrgbVpdg6WuF67ExCAqwqVhLQJyc/zI3CEUA6yXbEex823z
         YAiWDvclV0IKnzT4wLOTlUszVn3/AExtDv1HAth/XR67so0C/Sc6rwwaHG01nfLcO/vM
         g4JLbvXB91rBE8KwJfYJfpKzTc1ZYHR5NsHcpfDOgO51u2TD8kdOKdZTzCm6x1sGIc0K
         q5jZsodDJ9hYZs59JjSmUxTADqcFhQ1sPbFYBmTD//4IoD1MkW6LiaLqMh+9ns5HQ+WA
         HW/thpuXMCCQokBmhv3Vi3vEQBjHTMEAWTHKCSjNI0ILYOtrQlEyIRCU4Xy7O69qGop/
         tYjA==
X-Forwarded-Encrypted: i=1; AJvYcCX+Yee7fd5GCDn353sg9I2ZGueeEsRF0URbfxa7+pxEohUOnhbH+WhRRFYHhmjTjFLAcQJWAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaMhSDlMHE6mfCC+VUcZ/dM2EcXXItGVAWaW88mCIMUKOyQmbD
	q+o6a1T8Zf1C3kKCvgNCpgEOFDM2g/+8k1VPg706qHOfELyoqV2vo2I3QIXf6Mw1tGrBQjCaKWp
	DCTXbskouBTLo3IbaihQ+J4QViyiRAG1iqmMaiA==
X-Google-Smtp-Source: AGHT+IHPN9LFslQTM1gMYN4tKKonS0hsjh0tam1Zi62PvgetLTo885uAHaByvQOqprrT+VS/gMQK9GARTq8LGeXeZ6c=
X-Received: by 2002:a05:6a21:9217:b0:1cf:3461:2970 with SMTP id
 adf61e73a8af0-1d30a9bf6dfmr20527541637.41.1727159264301; Mon, 23 Sep 2024
 23:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240918111826.863596-1-linyunsheng@huawei.com>
 <20240918111826.863596-3-linyunsheng@huawei.com> <CAC_iWjK=G7Oo5=pN2QunhasgDC6NyC1L+96jigX7u9ad+PbYng@mail.gmail.com>
 <894a3c2c-22f9-45b9-a82b-de7320066b42@kernel.org> <cdfecd37-31d7-42d2-a8d8-92008285b42e@huawei.com>
 <0e8c7a7a-0e2a-42ec-adbc-b29f6a514517@kernel.org> <CAC_iWj+3JvPY2oqVOdu0T1Wt6-ukoy=dLc72u1f55yY23uOTbA@mail.gmail.com>
 <2c5ccfff-6ab4-4aea-bff6-3679ff72cc9a@huawei.com> <20240923175226.GC9634@ziepe.ca>
In-Reply-To: <20240923175226.GC9634@ziepe.ca>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Sep 2024 09:27:07 +0300
Message-ID: <CAC_iWjLmWtN51eLnnuPtL5vzTBQF2v43zyoV1+AZqUmuSD1DGg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Jesper Dangaard Brouer <hawk@kernel.org>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, liuyonglong@huawei.com, 
	fanghaiqing@huawei.com, zhangkun09@huawei.com, 
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, 
	IOMMU <iommu@lists.linux.dev>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

On Mon, 23 Sept 2024 at 20:52, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Sep 20, 2024 at 02:14:02PM +0800, Yunsheng Lin wrote:
>
> > I am not sure what dose the API that allows netdev to "give" struct device
> > to page_pool look like or how to implement the API yet, but the obvious way
> > to stall the calling of device_del() is to wait for the inflight
> > page to
>
> It is not device_del() you need to stall, but the remove() function of
> the device driver.
>
> Once all drivers have been unbound the DMA API can be reconfigured and
> all existing DMA mappings must be concluded before this happens,
> otherwise there will be problems.
>
> So, stalling something like unregister_netdevice() would be a better
> target - though stalling forever on driver unbind would not be
> acceptable.

TBH, I have doubts that even stalling it for small amounts of time is
going to disrupt userspace and people are going to yell at us.
I am gonna repeat myself here, but I think keeping a list of the
inflight SKBs that we need to unmap when the interface goes down, is
the most complex, but less disruptive solution

Thanks
/Ilias
>
> Jason
