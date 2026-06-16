Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0534219EA
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603356; cv=pass; b=Jq5eDno/L2jcOyPWp8HTHO64/M+5CdAGyYh4Utp1cCMX84wQCv/cSPJQF4+spYOmns52EMmn42YwBAeCOS+CjX8d6WHiKpg4eX5fWYXJCMwLQPzbM0c1t983yw9l20V8i8VJPlmBmOwhoa4Uq7hggIeYykqf7ZcXtAl2K5DkXJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603356; c=relaxed/simple;
	bh=QjEqLU00etgxuyHhjOjo1O1DD6A8WJ0GvFeC5XpYtfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpCG3tsrUo6GgnpvJV+qskHSq+yDZJQQ1z5eSoIWxAEFesMRn2g+wyfnLPm0pccSutHMlxNHDE9drEjHsrUVMGgA1a2mRA92Pt8Jko7ubCWxMYdqtjbAkUSb7L9IHMLu4XysU+5JuH01WwdZP5R9/0ig0Fpuh+1F6wVoXva/ETc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tUGtd67k; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tUGtd67k"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5177d1ff061so52781cf.1
        for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 02:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781603354; cv=none;
        d=google.com; s=arc-20240605;
        b=ckUvqNZwlv7NAtHc67gtVhHFBAMcIyRFlGzAj7DeU5HLTc+WzKlWSu60XlLg5K3P1V
         RlrIOGPwTYNzIwiMpSpjbEVnWxJV2NZi3zP3g2kkSCwWJTqiPTkwnR9dMSIfGG2sHr1q
         rEXVbz5STjnCLeHe2+Oj48B+yMM96wfD6CY3dJmVl/WF3Lo5hAtYiMt/u4ozICJJT856
         xxLFreeYOK6KzgpbaQosCL9EOF6oUv5etFt27REEw1w2c7f65iPg4Bpnv5CQMIUNLWP1
         fHWDSvBAc4K/+nMK0hoE7aA3z7l9r/6vg8rhSXZuv3LlYE7RMnUZARZ24E3AB2mdNVgD
         c07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2/X+IQDU5vWc0Utt9YT+71W3AhmdLwN2v6pALPN9Aqg=;
        fh=MKtkNdTld7NAgGJ2qZj/XtvY9HmKftTDW0wFiMCe70s=;
        b=f3div3XWaj96E7UDBZOhYJbC+LK7hRsvFJWnhXCZ/Z+9+gNbbCSAmp6R65VYCsurJp
         lBUkH8SGRKjs09xt68Gux3dPQOD8VIZgSouxSvkzWzm+hykDODs/m+rLnkssXOn3DteH
         COJ60+NZhUT4wDa22BkR6Si8CDnK/4/ga8hrlzMZ7AdfNKcv4GkipdTGFXsrr02MKabC
         m+FRfdl3Nm8GROqhGUraEjXf06ge8RXiyoqgTmBhTGMEotOmm6exnG43tSavsotn1dLJ
         7X4b3x8msJ8dMM9Fmsxi16tHfRTU3Kxvk5hjTdP9gwbL62Caq9yo69vV0TOi6efCHN5z
         5Hug==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781603354; x=1782208154; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/X+IQDU5vWc0Utt9YT+71W3AhmdLwN2v6pALPN9Aqg=;
        b=tUGtd67kqJ2cyUSjhkw93Ahu+/Tj8T8pHGJJO+o21fpPi3tOBkWR9hGsZZlv48UdId
         676OXb1B0lkUmL+pEDtal0I7TLfcZa9ClUkbysp2G6rJJm3WWTDZUovOOBs5oX6OoKGg
         +BCBUyeJo6FLKotAOxB3Gghme2BqT6ltQWsSY648lA92AG9iiJBst6uOnj4XbDTWTxWF
         sL0Z6jnfKxs5Y6az0dmXPZnBAoTCY3aTjClLccLMoyZ0KJ6BWJJdb3+8DeLMxP8tlGSY
         3FQn4ICOR/w0aqpnyTQkLtGjyzf+UPKBJ0FZ/yqUqWmGfBhuzhR0XYkQYLYE4pHZJzuH
         WR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781603354; x=1782208154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/X+IQDU5vWc0Utt9YT+71W3AhmdLwN2v6pALPN9Aqg=;
        b=DQq1Lk4B29zRO5VTa+yIxAQ94ExL/hn0pfvIG8zHaW0pp5kJKCQO6r3nS1V1YoGD6v
         YuQmrNFjvvwW0vYexRGrigoXkb4XsXREs/2zC6ubofx+UzXdVr0VIPc3aKW9OPvm3ois
         9R6LG0V/TGuIUHcwzuJrMKCBW8Aj+HEgDLsTXF5Mbft7Us8THLRzgtXbFMrOebEhyGBI
         Ixr7aL9L9vG3IzO/nmbvw6cm5Sl6UontuerTa0fyeMHulCWZWezg3Za1ivRwUnsuk6J4
         uLlAJeI5YcR3SRLyPyE2eV20FMcDQkYtHoNjMsbB2fkvLQ0uLCtUGGUB90B3DPML/YNk
         3+YQ==
X-Forwarded-Encrypted: i=1; AFNElJ8JpSxpt0Ny98jO4HRdat5YCzFYa6M8rs8INmXph2m0wAQzfzAjd/wGgxbr70UEssjpqn/EeA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+k3iVFh683Y5S+Kwm7+S8AFM8yBc9T8aVkMqgSkixFf2Ausl8
	s9b9WjR+78z239G8ZpwMI+4wYc5XtSqv/F/92uXuUPIbpTUBbjjRKdW8mHoM6Kdjstjg3FYEkGu
	GVBM1KpTYCkybNxj4RfZH2H3hvZp0CNHZ0UtfVnQt
X-Gm-Gg: Acq92OHpiFdbryEe001tApwfycmAPBVbh/Ik7XN0JYenOVcuKMUPulV/JUCmzrFjuzG
	ZWSnyTZqUXUS7IGlq5FpyGEsAm4LLBHkTUYt3y+/mMelJADkvMLzfdlnra+ZqJzuCBx7jOKtO4W
	AwB5cEE9qMwPjUVOzJtr59Q5Wps4iUqc3LWjXKildbYr8C/l6KmrSnBgPFcFgtLogLQfXQBoqLA
	QPPzbgDZKAs5T0OSFeYgwjF+WjPKB/RXexy3gm5W6krUgzu09taMk4rpDlqy1M3gUEw60oZ9Kx0
	GI1Jr3vc
X-Received: by 2002:ac8:7f83:0:b0:510:f9b:fb5f with SMTP id
 d75a77b69052e-519904708a9mr8164151cf.16.1781603353313; Tue, 16 Jun 2026
 02:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com> <ajESl4osXP7roz5q@pedro-suse.lan>
In-Reply-To: <ajESl4osXP7roz5q@pedro-suse.lan>
From: Luigi Rizzo <lrizzo@google.com>
Date: Tue, 16 Jun 2026 11:48:36 +0200
X-Gm-Features: AVVi8CcHZ3OPXbKC4trSPNuaSPbYaO79J7ToG8S7bAu191E2DonWT9FNgV4gu7M
Message-ID: <CAMOZA0+L2+=FEQ5ORvv07JaJix0R+6Q6u01CyMKCbd842To9nA@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
To: Pedro Falcato <pfalcato@suse.de>
Cc: rizzo.unipi@gmail.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	willemb@google.com, kuniyu@google.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, akpm@linux-foundation.org, 
	david@kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 11:20=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> w=
rote:
>
> (+cc page pool maintainers)
> On Mon, Jun 15, 2026 at 11:42:20PM +0000, Luigi Rizzo wrote:
> > The use of swiotlb causes an extra data copy on I/O.  For tx sockets,
> > especially with greedy senders, this has a high chance of happening in
> > the softirq handler for tx network interrupts, creating a significant
> > performance bottleneck.
> >
> > Allow tx sockets to allocate socket buffers directly from the bounce
> > buffers. This avoids the second copy and removes the above bottleneck.
> > The fraction of swiotlb buffers allowed for this feature is set with
> >    /sys/module/swiotlb/parameters/zerocopy_tx_percent
> > (0 means disabled, 90 is the maximum, to avoid persistent I/O failures)=
.
> >
> > Implementation:
> > - define a new page type to unambiguously identify bounce buffers used
> >   as backing storage for socket buffers
> > - modify skb_page_frag_refill to perform the modified allocation
> > - modify the destructors __free_frozen_pages(), free_unref_folio() to
> >   handle those pages and return them to the pool.
> >
> > The savings are especially visible with fewer queues. In synthetic
> > benchmarks, senders with 1-2 queues would cap around 50Gbps with
> > conventional swiotlb, and reach over 170Gbps with the feature enabled.
>
> I could be wrong, but I genuinely think that the way to go about this is
> using page_pool for regular TX as well. page_pool pages are all dma-mappe=
d
> (so whatever swiotlb optimization you want can be done there), and the ne=
t
> stack already has awareness of these special pages and special skbs, so i=
t
> won't Just Return Them back to the page allocator.

I am not sure I follow your comment above, can you expand/clarify?

The problem I am dealing with is that the copy from the socket buffer
to the bounce buffer is done in the device xmit function. Under high
it is almost always done by the tx softirq.
This means that even if we move the copy outside the HARD_TX_LOCK(),
it would still be almost completely serialized.
Hence the proposed method to make skb_page_frag_refill() allocate
directly a bounce buffer (under specific conditions) so there is a single c=
opy
done directly to the dma-able buffer, and ii is done  in the user threads/C=
PUs
and is not seriallized in the softirq thread.

I am not sure how page_pool on tx could help here.

cheers
luigi
