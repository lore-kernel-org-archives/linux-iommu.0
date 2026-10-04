Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C719C553
	for <iommu@lists.linux.dev>; Sun,  4 Oct 2026 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791105311; cv=pass; b=Pg2Do6gyQccn0e16503riEuY0hA918gG9MAJCjrKrPMLI0WwUz5My406HMkbjEI+Bb+vf2kDB0m7Ly1iasr6GlDkxD4sx/7SnG0cRbeGKAu/xOPFNhvQlIPaeKcgEz6tEDKE6cmyCYv5bG5rAtS68kuO2KcgVl3WLDjcn0oUc1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791105311; c=relaxed/simple;
	bh=t/n84oizsmqf30Qmzu71biJDzzYUFf3OYTLdCk6ENu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTt+fto9DO49Wl5mRSSjpR1q6O2BllT6OSAVBsZcvU09HQIyLrpK1ad/8hJXI1NgBYen6rBzMse36dBBpVC4VJcNRtnUMpQgRRpY71Mfi+Ht+7SL7i8Ae4d6AADB0asGWYjACgXps3h/KHgQNHahe2CD88W8a+ISYRx9mgGSf10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iicZ+ucl; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iicZ+ucl"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398a5aad413so450181a91.3
        for <iommu@lists.linux.dev>; Sun, 04 Oct 2026 02:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791105310; cv=none;
        d=google.com; s=arc-20260327;
        b=cm8X0YKD1VbzcemX8NgOuuDbmRBmjFy1vfulHZa0RdirjR9yJmUmGAcc/+IDPfveKL
         cEMILGXwV/y1IpX5I0SSXb+FLVtb8uZreR39ESvm5Ress1oGXJVw6zldgg6+TAsHOxZg
         hTZ4cORR3JQkdj/HaYna3iXJ295BspBaD0CeKzIjvJO3hvF4NOtkf1Box/5/3IPYj5/Z
         jHZ1WezSVLlF4QN2z61q0bFTaDty/GsXZeuRjHgzIno8uraK47HyIAO5hOeaarHDEVQj
         T31CMNLzfCSfAxz0W8Ev0THp1HB9nxtsnWc49aM1K3oOluTQa17bCtB3p+LFvkN0wY7k
         33HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kaMhgqh0cNyzIJvdM7MdSJL/gkpQL52j+U/jEExbMjs=;
        fh=WQLNlbAiNCwli+UD61174HQFWEN1KdO6K0xJEO8UxT0=;
        b=E/bMrjuLvbJ6xosaIHWPb/hkzvZWv7jfgOxxz5sxWk09Hufd0PeLh328kFdbh2elz6
         ko7c+xNdlBd6mu2UZ6gg8KmiPGP4AeESF14fJ9Mgtl/0E5G9r/P6aGbU41r8FQ0A1xww
         RgEtWAAqwBFr+/i1EKFBxtMfevfIwYkHbyM9gcks1T/02uTP0jPjUV1Syn6q71mkqBsB
         27T6SKQ2S861B1NhLW14koSeBFDpv5HGFa5xZh5hQVFuYTdU8rzutzsPyR3rQEt8D78G
         EL0GvLTXSkFCaxtaHjhzNHOm57BWlPOzZmDhPFAHJj7Czoe6QuWUXV3ugbu1SlclhR8A
         M5dg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791105310; x=1791710110; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kaMhgqh0cNyzIJvdM7MdSJL/gkpQL52j+U/jEExbMjs=;
        b=iicZ+uclc/Lp6YbAIqkFB4Wl4eJRydQ+tTDzsraSStZHJlE7KE8njGEeB6N+MSgWE3
         DwLGacJeqFFJAW3xPSSCpjXwtWFLEQVBjC8zhzyE0xs5wfq5hQjW+/6cHa0jxj7U3tLs
         Mltts3TSIl5TFhSXaNhAT28cUECnOiKZNFk/NmtUDcbUxIChNIoYsW66qMm+wFa/kiJc
         igmpgwXnrvjw4C28G/hWk9LkxYE1y7KYOFeflURnQOOWFRIaakv9YZ8g2VarR8PuO7ox
         TucHwmbPK+KwiHky8zJ4TiLy1qPJqpmnUaGQX3Cn8K+zRxiaXR2cjSshPsRhtre29pCf
         RSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791105310; x=1791710110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kaMhgqh0cNyzIJvdM7MdSJL/gkpQL52j+U/jEExbMjs=;
        b=QIvF8skrqPTbYk455TTyBIBUpCFZHInLO8nmQc69O4leqv4q9vmsqxVcWmhcOG5Ui9
         2MK47Wl7CsHcAhM3k5tkZQAI2M35DSNp+rGqdyB6t2olnLBk8Fc/qyA17upEw90oltYi
         7//b3JQtPvTHb3E/YQTPsLejsp1MglmB2sgfNYnSMwjbr5bHF/k/weD56bHcojEzFJ04
         KpBGk09Z7bruhYwVWci/dXJCN4/YxCmXnv+cwy2PlF90Pe4r9/x4jdbvOS/G5E/1dR3r
         lkPAJy49FPLK4u0nUMunSLG/XFUXDh2rebjkyKQzSruHjQ33pPSHzybVE0ECwniIy312
         fAOg==
X-Forwarded-Encrypted: i=1; AKwUvBxHVlkzI+bWng1/ukP+C8gNknTVvPyFDKHZLO4lbE1OupiaPGjpz+8T9MUpCI298AkSPrj/CQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIAHn2bSxyiqo7HXp7jSDWHTxuiYSqSY5t+Tzno862T76pqn4tj
	1EvH25XbQoVKSqEELM1ZWSNPBxIoc9H5Z+wteV8DI0khIB0uimUWahMbxFTz3C6hQ6V76mXroiA
	2uygOOxUJKjtZHtESEQNcl2iqTViR4lY=
X-Gm-Gg: AYBFou17WnG+V5ve4HbtRO3LMIIyVGxCfUkHxMo/xo4dX/rB7BctUGeGvkk0RHi7TLN
	m6XU0QO3I5dByRL2TxtXtkxidrZ2QctkZZHdVnbgw02QmHkKFx1W2+9nE06EvWGmDXsWnsXpEPL
	39ic9an6kCpr2Eev1G2jUk+SGNB91uTOesvkPvdHNXa8Juo2gqXU2hW6PBNfA1JGdtI38lWWVLP
	d/wDDR366EQVyL8FJpJaGpek+nmoxJhcsRUzsu1Pgm/3De04+H3U/DuCXBi65JkXn773x3EUWJP
	NFcMQ2sMgfUno4EonyCSr5ARQJOk4j32GxKxasBT4nVJQiO/zdR0Aw==
X-Received: by 2002:a17:90b:2548:b0:3a0:d651:3957 with SMTP id
 98e67ed59e1d1-3a7873ac66fmr3158501a91.35.1791105309539; Sun, 04 Oct 2026
 02:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <20261003212241.3432303-2-lrizzo@google.com>
 <7ce092a4-5c85-4391-809a-3d04b638a722@infradead.org>
In-Reply-To: <7ce092a4-5c85-4391-809a-3d04b638a722@infradead.org>
From: Luigi Rizzo <rizzo.unipi@gmail.com>
Date: Sun, 4 Oct 2026 11:14:58 +0200
X-Gm-Features: AclHuK-h1jLN5HUM25V1KDJrvXlK_1XFkjlYVZ2OmcSjQmXYi39ZO7A1D8RAYWw
Message-ID: <CA+hQ2+ieCiXpnRzv7t003cHKG-YL+jSOSgVO_KavGEkbKfOeuw@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 01/22] iommu/dma: introduce CONFIG_DMA_PMD and
 metadata table
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Luigi Rizzo <lrizzo@google.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
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

On Sat, Oct 3, 2026 at 11:44=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 10/3/26 2:22 PM, Luigi Rizzo wrote:
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 6e07bd69467a3..1bb347fd9da4a 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -158,6 +158,38 @@ config IOMMU_DMA
> >       select NEED_SG_DMA_LENGTH
> >       select NEED_SG_DMA_FLAGS if SWIOTLB
> >
> > +# PMD_SIZE IOMMU backing for DMA-coherent devices
> > +config DMA_PMD
...
> > +       Costs 128KB of metadata per GB of DMA_PMD buffers, allocated on=
 demand.
>
> Paragraph 1 of the patch description says 64KB per 1GB, not 128KB.
> Or am I mixing things up?

256B per 2MB page, 128KB per 1GB is the correct version.
The number in the patch description is a leftover from an earlier
version, I will update.

cheers
luigi
