Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F365505C2
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792002525; cv=pass; b=AY4EwCMSpmLnhOxom0CAyEZvAyQUluWWLgkGTcSiHVfsnVGdI4gQ9yXA5yDPeDrt7Tdw2uptz9KgS+vlcV6logp8ZXL6UNsst0z4misJWIPsbrXQLFfgGef50PXboz6pOW4XOGf/Sk9ewQQtdA18LipjUFHV/p20n+4NhpJVWHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792002525; c=relaxed/simple;
	bh=0+JRXvl/R9u5pNiuiBxqdsVIx1pGWTS2oCduhPjMn+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1v+B8hAXCkm2haqcv+23xPsH7FDYTjMaeE5GekSwQNTedDvAVvazzmCE7MJbxH9aeb/Ada5TAKMU/BW3N462AGFXMM/tfL43MdAh9FczpwlhnS/hC75VDZQFk4CP/tydRWgmjz1p31TL4aqmUP+miXht2ya36OQ/xCAADtqdfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XKUQdDFL; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XKUQdDFL"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2db33db4de9so249345ad.0
        for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 11:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792002522; cv=none;
        d=google.com; s=arc-20260327;
        b=faTLD/STSGvc659hXpCmRUqXP4hmZzGtq/nwHg6pse7xjXNC5ewwIxP+EvBc5M712V
         N+htq2F08GSXe7ZdS0tWopInRyBijUrT3Wmk22F80AhFwclzHRNy/9CxgioQyG8D1Ajb
         BfS9SShDyBIpUl/DqYx5E/TdFs7qN0RhTRp0I2XQ7qthn4/M61r+UKF5Y+qqJirab26r
         QzBnheGW6JMrpJHy8KxLx3CNwbvq1796LtNcyzUWlY/6KuYVGxTTMCb9VGzglsnq/0qc
         Nqm5EgKRsdOKqKEhVv8pjfmFQO636hVpFcJEjASmnnqwggiUPabQSb6kLpbabHPfcRn8
         hxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0+JRXvl/R9u5pNiuiBxqdsVIx1pGWTS2oCduhPjMn+0=;
        fh=GRlZT0liX8h3Boz8kfpYTgcsurJ01mY8kR/PkY6DfYs=;
        b=s6tJRLl5eZW2fIR0FVH/z5reMvxsca7nT9Ecf8Q+y+0OeM7/mbjs6tXFNYfMZK8OJn
         wJwpfppn976L441uyYaFXGPtP5p2UjLaK3TairCH9Gdm4kL/O/Uo8/SQIJHWl/pJ4Uau
         LnsrKNH/Pjt6Hty4ojEVP9YPD9uU3CaIigL/Zs9r3FVmbU3nSWuV/9WSxE6utv0II2OW
         PVxowRpGm44hW/GykaZZ7fsB+BuMNcCFFPVABmKoEfA+1KQCWncZVOM/UNzQB+TfF3Nl
         6dj2/ip57KbUzgKAHQPJyL7iQjCoAaj1CCl7bfBxh0bJxZaXdH8VqIJmv4WV4J9n3KVC
         GqSQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792002522; x=1792607322; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0+JRXvl/R9u5pNiuiBxqdsVIx1pGWTS2oCduhPjMn+0=;
        b=XKUQdDFL6+r/EppmAGWbckBkYphrqgxbA/KutD01423is/o/KEG92dsYK0esacD32r
         5fhNrE7wF8/+WziP14kSSLtjjSM4bimWAaP58XVv8Bri69MCTodylA0ooKJjnfgUnAIC
         t86DM4S1HnM++RocINvqiWbsbRp/Mzwch7d00jY1oeWuKE/sKxdyKVA3LwD4GPdJQoJ9
         fuaYMMOE8+8OCDtPovdKkzvbFwktK0rTuVGRhWdWp6gAs11E5ROPn3I/LsvnlZgfwOZL
         MqzZcMF8xi69PBckOtZw4qK5ErOLW0bCABmmPVG8jJxzVJVN+Cpg7j5lfsm2FmGY1NJg
         cguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792002522; x=1792607322;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0+JRXvl/R9u5pNiuiBxqdsVIx1pGWTS2oCduhPjMn+0=;
        b=uPY2bwg6yCFKZMi4Dx3x8WplR6KUKuQlVaIS+KjZz6hCXoUTV/kCB/iTSNQkGIh3qX
         rqWtzQyC7iTpJan+WNuFbqlZciMFRsg0LktM+oKuLbuZD5PZ+PvkROBkUdaa5K+8SXc3
         z9UIj+KV4fG6C1qbhcVHEkIL/UdXJelFA/1cUY/ln3Kd9Au640JLOzW9DH2VVjx7J3YH
         UgtBH499Qa2wENpST21/M/PNez+CXOYDU56rGEW5ez1LJ38yg7xCj5qSV1YqFuuCJcXs
         fEfZvctrv1oPCeojg6tppk3Am31kSNNkcdqNA3e43S6o1ILEF5eOZC2iAPmlRlzlLGVa
         SU2w==
X-Forwarded-Encrypted: i=1; AKwUvBxjWwJwVTe/nx3OOUaZ8UUxIkX0J9JbTrVgjOuOt8v88IZ6zX56Uz9Tf1ZzU6vMmcl2BAqh6w==@lists.linux.dev
X-Gm-Message-State: AFq9FYLIouh2QtLAOaBKQtrqairLRMN74qrb2y5Sa/GDC+cOhinKGiN6
	xnxTd8wa2PrveePWnXxlRaUMQ17rQh32Hh3k/ahEP0uvFu92zPbFT8LRuIslb2MvYCTbHGjIs7u
	LXItIVMf/JnNV2jdBY+9HkCnDH/1+fZt7PbODsEOQ
X-Gm-Gg: AYBFou2J2C7mbBoWyaPwQZZuSmWoLtDMfoZ9BWRk5VUYEnNNgMIADcho5XqRYgYSpcF
	m4ZOLk44kPFO7oCa6Cu46giih9lMsgCmWd5zuJfD8Ywm1jL4oqJfNY+hUtfbtAmME+RWl5MpI5r
	RVyEIbBqi7QpBtu0eCRGfr+7mcvloB+kzp+Hd8UEmB5SB/bDijFqg2kaUxFM1N/Zsy4yNJDhiWD
	/ULW1XWfzdBio9vPp+DsaRfpv0YD4PC4BcyyWx+NG8jZA36RELmqcVO7IITEz76DVnqyeS9ercQ
	HRyiVbKHaT6vjv7zlwHCUkf8zyncA1zDNpfbqsX9sBdw0U4F2uv3MVXk
X-Received: by 2002:a17:902:e944:b0:2e5:4604:c37a with SMTP id
 d9443c01a7336-2e87e303708mr18554105ad.18.1792002521805; Wed, 14 Oct 2026
 11:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <20261003212241.3432303-20-lrizzo@google.com>
 <52a702a4-14eb-4617-bd29-e3140fd36780@nvidia.com> <afff5a1f-000a-4216-b4df-dd3d0406047c@nvidia.com>
In-Reply-To: <afff5a1f-000a-4216-b4df-dd3d0406047c@nvidia.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Wed, 14 Oct 2026 20:28:05 +0200
X-Gm-Features: AclHuK-6TbXuD5dQp6Q_-RxWjRRPPqkpIpvGcrKlslQ4aEjsOkMcO7VIrHzh1iI
Message-ID: <CAMOZA0K4ZV53pE41AKoKz1g2wz3YENBz=HVoXng=RZbGyN3ssg@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 19/22] net/mlx5e: Use DMA_PMD memory for tx header
 bounce buffers
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 7:51=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>

> > On 03.10.26 23:22, Luigi Rizzo wrote:

> > Why are only headers considered for bouncing? Because they have the
> > highest mapping overhead?
>
> I meant to say headers and small packets.

Headers have a high cost for the map/unmap (especially in strict iommu mode=
),
and also cause significant IOTLB thrashing, because they come from skb_head
that is not pre-mapped. The impact of IOTLB thrashing depends on
the hardware and load but they consume one IOTLB entry per packet with
almost non-existent recycling.

In the following version I have modified the slub and skb allocator to
feed skb head from DMA_PMD memory, which removes the need
for header bounce buffers. It is a compromise (the skb head includes
skb_shinfo, which we may not always want to expose to the device),
but gives an option to those who want it, and in that case drivers
that use pagepool can get all the benefits of DMA_PMD with zero
modifications.

> > Note that TSO/GSO packets will copy the header inline in the WQE
> > already. But not for small packets.

Yes additional bounce buffers are not needed on hardware that are
essentially using the WQE as a bounce buffer. I'll double check the patch
(mechanically generated).

Small packets should not be too problematic, as long as they come from
fragments allocated during the copy_from_user.

cheers
luigi
