Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442040;
	b=bIbVPb4iNvwQwxaz6wxpN0fjbEUVFU+f8Tiu6gg54RRUPHNgQEUkpDeUxHZbH8bmw+En
	 Xc1i6X95WQbhdoUELav+75T5za1OxckdW0S/lM5+wHoO01/JD+L8Mq0M5fGo5Ll4a5JMA
	 wEIP1MqxJksqjtqlNFmJA2A3FX7DA2ZvhA6ShDNLV/rpNOr906ZtHGMPklT72FuLL/rzy
	 BFh5VMOwTLNLXuMdu3M3yWzkLPmReNlATdTmdsWV7gL3C7kc+PvLbvLjhhxZfeJLsqimT
	 ns9Z1pgeqXEwEDa0thbJklUm5Tm1Rg5P58MVqRd9fDlY6rHULKdhz0dUb7rfq1FnUsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=MOqSPuzgFkgUUA2YNUWCC5n6SqQAFa4aMwyIiBrPSGc=;
	b=TZhB0BuywIss7eesoV5qf3gnAPTWPlIH+wqd4p6PBp88ZAN4/yH/TMGLDe5VNSHb/RLy
	 3nqr7LAbQuX+ETho2pGjI0GXMfqe0XVFk17TGGy2fmzwtM19wmJoYRV4iGcC1Vg5DIkPo
	 TlM9ESCie+bP/Hvdh2ku+cKmDb4eYUkug8VxOQOnIWnoo5k0/LX3YssTHdtDGKo/t835e
	 5yiKGaZpzfWB+Uv/x05r5p2S88V9WAE2m3M1UwZULBgny8Cddz/i/tZu153r6P3u5KAbo
	 jF0H/mvUdgXJGO44iz/VhIsBBel2mdOeaQ/+5Q+YDXb6rIGb8873vM3jBB7/SNJe0OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SaGQtaPj;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B97606A31E
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 13:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1B97606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SaGQtaPj
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f048bc09d7so98335ad.0
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 05:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795442039; x=1796046839; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MOqSPuzgFkgUUA2YNUWCC5n6SqQAFa4aMwyIiBrPSGc=;
        b=SaGQtaPjyQqTzIS0HQBIVTfCrjBLwcBrJeB/jkbZyIdihQqnWziI2ZxcCy4tAUIkPp
         JAN6UGKbznOQKsoS/rP8wbuN31V/811bI573fePxHFER9+VFpMPDvZbDzIELrEg2tK+q
         lQ7Co2YtXEpPXvXlUsGXfYo4nzgUB378G2pKuxL3uMPlerN9PYDr/u9QlT2YpDjlxfkN
         yZIUU1NILjL03DCipg705AIWu28rMNHsenvWNM2Rqf6pWtOj69FjkPpkoFPPzvUMhyHl
         ZYXV6oK62Q/OAwJI2bl5SmpwsAVgCI+QWGhQ7Vd3TFnhKkzKXySTjcDqPRJNYbjqKeri
         kXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442039; x=1796046839;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MOqSPuzgFkgUUA2YNUWCC5n6SqQAFa4aMwyIiBrPSGc=;
        b=AIia/mqMErZhtsG00hp5VYHMxGgrvG0UtPsAgIFJSdqfEOjhW2cJLDuagAxutTIpbN
         f+bIC+0sWnqk6gIBXyXyXsHWEM2/2meTNE9cbN//IdYBADqk1H2wA3l8prIvHFV9AzSb
         tf+QNZGYrPPA6XeUCSJny7VB8/HAaqRPCtjO/8+TTCaxDT6BHK3j/qC0lRioHiS2Ai2S
         Ye/Jpo1aAzLWL76gxYSB84xsd/a++f4Iq3BRH4NwhU5IdJomEb8KxHTS1ydoOZFUd4w6
         g5xp6eiHdVmnpVRIItUHNkjwqybiR5Vmk6Q9J0uDCz0PoY6RucppCZxaV98j3QasSg0D
         HsrQ==
X-Forwarded-Encrypted: i=1; AL+hErELN3qLE+Fg1rQRnWCKm467uaDi4/Rqu90Po1NLqGuJYsfoa5EwOwHZmYrIoIRIfAiimalaWw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8/pZ5DCtmVUQKWgJ//nDQ1QDd5zYhRUd7sLdf9kotH5XZ+D1We
	Ks1Qn6QckL2qXGd7YQ52Nu+BRGsVQ2b9a0NPL8kDQH8QGdae17MVrNgP8ENIjrt4eg==
X-Gm-Gg: AZFdTZdhXxaDKmEu/S68pY3wnurY/Qola5TsaRS81paSi/v4ejVkwnOCzN0VZJSVu57
	ZnfF/jVlq3HWgrOWThhKWBzAVT96CMwzuj9oAtJDZZzzhk7zm/bd1FwTfgJnU8ojY0AvALxDHy7
	inp1Y3FDWwExT20SxbueH9h2mRmeMH/WwY5QoHFrAls74zTYKpglnGV50Y5Ybe8e5S1rmp/Gy9d
	DJ9Y3kRlsxZfN6c40CstNsXKVw3yOPimqaDs25KMaXGfTiVu4MFrQBkxLONbq4dhwty/wPKhjKY
	tQHFQ3QEsNBocF6nXSSDq52dVnosax40IPQHgUK1CTlsw3QvK68bvkXZAOjmyIJNTXvozI0qeOh
	N24o7e/LN7bg48/qbVDzl9ejZya3a+S3k+tq3Vs+lFRa/V1Il5qhPgcD1mh2elWczxXR9JJbhnD
	Z/0MShU6tLXXpkAii+b3xvRscD/msfoFyHELzXuDr6pcDFBN7bTUFpZNmkN+1SZEeEoe0wXs66g
	3VexlAsj0zfjjE25ZqFIeiyZx4YdrS0+1CIFwUrEAkGDnWCfJHb702DFDqZAM0fjnD5W1adR5+u
	PQYaRbq8UomQK/U6I4GVteoVilSLZAp/mRHbq/57+pV/5DFdye0via07q7T23y7IvFA=
X-Received: by 2002:a17:903:3c6b:b0:2ca:4bb4:4bd with SMTP id d9443c01a7336-2f062bd72b9mr7103195ad.5.1795442038751;
        Mon, 23 Nov 2026 05:53:58 -0800 (PST)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b73b2b3sm7836326a91.2.2026.11.23.05.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:53:58 -0800 (PST)
Date: Mon, 23 Nov 2026 13:53:51 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <awRFb6Q6WW1Ys0vq@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <asZSQRSYBjbUaaH0@willie-the-truck>
 <atXTtaxz0z-U-XSJ@google.com>
 <CAE2F3rDd23TcWELEu0hNZiw+At==HZjZ=4KWGc-KPoZ4YiFxSg@mail.gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDd23TcWELEu0hNZiw+At==HZjZ=4KWGc-KPoZ4YiFxSg@mail.gmail.com>

On Wed, Nov 18, 2026 at 12:27:58PM -0800, Daniel Mentz wrote:
> On Mon, Oct 19, 2026 at 1:24 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Wed, Oct 07, 2026 at 03:08:01PM +0100, Will Deacon wrote:
> > > On Tue, Sep 29, 2026 at 03:45:05AM +0000, Pranjal Shrivastava wrote:
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > > index deefb17e31eb..794b258550dd 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > > @@ -394,6 +394,11 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
> > > >  #define CMDQ_ERR_CERROR_ATC_INV_IDX        3
> > > >
> > > >  #define CMDQ_PROD_OWNED_FLAG               Q_OVERFLOW_FLAG
> > > > +#define CMDQ_PROD_STOP_FLAG                (1U << 30)
> > >
> > > I'm unsure about this. Bit 30 of the cmdq prod register is RES0, so it's
> > > plausible that the architecture allocates that bit for something in future.
> > > For example, if the index field was extended, then I think that would
> > > cause problems for the driver.
> 
> Let's cross that bridge when we come to it. I think that for the
> driver's internal llq.prod, we can deviate from the layout that the
> architecture defines for SMMU_CMDQ_PROD, and as Pranjal pointed out,
> we are already doing that. If the architecture eventually consumes the
> current RES0 bits, we could save them in a separate variable and only
> overlay them when writing to SMMU_CMDQ_PROD. If the index field is
> extended, we could artificially limit the index width in this driver
> or transition to a 64-bit type for llq.prod. Also, it appears unlikely
> for the index field to be extended beyond 24 bits, because
> SMMU_CMDQ_CONS allocates bits [30:24] for SMMU_CMDQ_CONS.ERR
> 

Agreed. Thanks for pointing out the CONS.ERR part, it does make
extending index beyond bit 24 less likely, although I think non-index
fields can still use it?

I like the idea of extending to 64-bits with an overlay thought.

> > >
> > > Do we have to put the stop flag in the producer value, or can it just be
> > > a flag elsewhere in memory?
> > >
> >
> > Fair point, but the flag is SW-only, i.e. it's always stripped via
> > CMDQ_PROD_IDX_MASK before anything reaches the HW and only ever tested
> > via Q_STOP(). It's the same deal as CMDQ_PROD_OWNED_FLAG, which already
> > uses bit 31 (also RES0 in SMMU_CMDQ_PROD, IHI0070 section 6.3.27) as a
> > SW-only marker in llq.prod.
> >
> > Keeping it in prod is what makes the check + slot reservation atomic in
> > the cmpxchg.. with a separate flag, a CPU could check it, then suspend
> > sets it and samples the target, and the CPU would still reserve slots
> > beyond that target.
> 
> I think that the suspend thread needs to ensure that potential users
> of the command queue either (a) observe the stop flag (or some variant
> of it) or (b) are accounted for such that the suspend thread can wait
> for them to conclude their command queue operations. For this type of
> synchronization, I believe we do need some variable that both the
> suspend thread and the command queue users access with cmpxchg or a
> similar operation. I guess that in some alternative design, we could
> use a combination of refcount_inc_not_zero in the command queue user
> threads and refcount_dec_if_one in the suspend thread, and I believe
> one of Pranjal's earlier patches used a similar method. The beauty of
> the current proposal is that we re-use existing synchronization
> primitives and don't introduce any new variables that we need to
> access using cmpxchg.

Agreed, and that also matters for the perf concern John raised.. a
refcount based approach would add two extra atomic RMWs on a shared
cache line to every command submission, whereas with the flag in prod,
the hot path only gains a bit test on the llq copy it has already
loaded, right before the cmpxchg it was doing anyway.

Thanks,
Praan
