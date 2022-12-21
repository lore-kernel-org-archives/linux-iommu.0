Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979031FA7
	for <iommu@lists.linux.dev>; Wed, 21 Dec 2022 06:57:15 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id o14so3740910qkk.5
        for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 22:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4sxT98fYI+xk8zCUWS+ydCJG4wsKr3bFWOVfVj9faEA=;
        b=fdZ/BGSXYcCSEMqBOsTxHsFUd6wcN4VSsB6nWXZliVj9vHFRUghLogNqLaV5v3K8wl
         jn17WrZsjfQ3rkgBlxh4Tx7mcDh+YEh4uq3O6XemdMI757g3ozdNR11ixOi/kGmu06ho
         Y/C16QV14FDf6PMgX+dl0vx5Ct/pbz6w2nnpNgOyUszVJraMzCuFZOeG/xuGc6O6oYk0
         X4mn6nZf3JKp9XIgcIfj/aX0+2pfl3aJnXH0gvIpPsnlzgKq2CLp3vUmiFUX/zesy10G
         3F52+P5mcDXVUVIBPH7HeK+s9hSZLRZlI2meJyxFCnS52dbWtB1gd3uON7t1tmgqNPGL
         qygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sxT98fYI+xk8zCUWS+ydCJG4wsKr3bFWOVfVj9faEA=;
        b=nCj4GkpMn0eOGs9kHu5plosc4bLM48hQNOdYcGlWQXQaa/kloTSdSWstSb8c8tS2ZQ
         uSpbKDE9LSK2LUW1yZeRGAqANKyctj/D/G2yKahxffIAJ8awKe+Q0KC6JyIi8UzaKxAA
         xyNQpuQlZWj9x/rrIM5vsmvueZt5qCpkCzot87z4zQvwilK2v//YQdYmTryohyXpCHlH
         jeqMcE7qCHgfa8dhMrTnpo51GMh73FUBnSB3IcTl3kDHMXrS0jKDpqD8j1GCtfn8wx6a
         Gyiwr1W54TwT3nC5EeUoFZ+JmQHccX1vanDDBTfamiBqoGa1/WnyrQ5+RhZ+KhWKFbph
         TEsw==
X-Gm-Message-State: AFqh2krKnRPd8pLsNgdH7thvoiUqKd6FNLolaZWTWYshIhPbJ6VFq1HN
	Y6vkSvTsBKUuklKg9ZmCAWDOSHDuuENUXavSrls=
X-Google-Smtp-Source: AMrXdXvqGt2iWo9IhQ2GhmhJkyX+ProoR4XL7/tRzJaLbwiQJiZoDGb2ZI/KJPVMoT7k7APh+qkrD/getxaqhjvjUA8=
X-Received: by 2002:a37:592:0:b0:6ff:9cee:cdb7 with SMTP id
 140-20020a370592000000b006ff9ceecdb7mr12532qkf.327.1671605834318; Tue, 20 Dec
 2022 22:57:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221220082009.569785-1-hch@lst.de> <20221220082009.569785-3-hch@lst.de>
 <alpine.DEB.2.22.394.2212201653520.3532114@eliteleevi.tm.intel.com>
In-Reply-To: <alpine.DEB.2.22.394.2212201653520.3532114@eliteleevi.tm.intel.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 21 Dec 2022 11:57:03 +0500
Message-ID: <CABXGCsN+oiy_P=LiUDEtOut_Aq2r+aZ5UZWETD-tj+B-b3VF4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dma-mapping: reject GFP_COMP for noncohernt allocaions
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 20, 2022 at 7:58 PM Kai Vehmanen
<kai.vehmanen@linux.intel.com> wrote:
>
> Hey,
>
> On Tue, 20 Dec 2022, Christoph Hellwig wrote:
>
> > While not quite as bogus as for the dma-coherent allocations that were
> > fixed earlier, GFP_COMP for these allocations has no benefits for
> > the dma-direct case, and can't be supported at all by dma dma-iommu
>
> tested the series and this fixes the issue:
> Tested-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>
> Minor nit, typo "noncohernt allocaions" in subject of this second patch.
>
> Br, Kai

I also confirm that after applying this patch series issue was gone.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Thanks.

-- 
Best Regards,
Mike Gavrilov.
