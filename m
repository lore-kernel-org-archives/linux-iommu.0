Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059C7227BB5
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080958; cv=none; b=HWVB8wMvay3nH9M12jFVAJCGl81L+Ifxcgww84BIGcX+isSFQkJ5CIOArMdRadvp9+C44ZuGPjSKMgILMfkmbSldkU9T1O0kEcZgTpK8ngTcNrVUj8+Hx+0rJAM6wLg6Q4MlLoakPJU0m/cey8m0C6p2onQg/5Hm/Xltef8bUtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080958; c=relaxed/simple;
	bh=1hWHgpM/rb70qd87juqmeSrMZFHqG1itquQCJwHGhEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J57KjRgLf4uxd036pYodaDoxdwcPu9Whn63uu6jqqypFDzQM+kjgue0w1SGNtSs0sfc8SU17mvOqyDYANJhiinftRtlptCv0nIPdBPK73HQdpz4ZxF0QflWskncRMQ2Z8SDx32gHhsJp2eYzON2VWwSzpi9ysN2anUfzlDwaFIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/1NBur6; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/1NBur6"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63486ff378cso7507341a12.0
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 10:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759080955; x=1759685755; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hWHgpM/rb70qd87juqmeSrMZFHqG1itquQCJwHGhEk=;
        b=b/1NBur6houioUR9rKLwKpNv26TqlqCeRLj5WfczSuDPRygdH4ryzflqZotNfBWnMS
         pYfXGAVfME5/1ppguir3d2sc1wizHv1uQu5RIogBU5v/JNqhHyosXbZy9iBczRYsB4Kx
         M6NzIvgY4xn4lawPL+b/TAUWKC1bcjNF3AErhy/J4DemRvI/X+Pq4Y595ueryii7r8JS
         HVWIXMEBxaPvzb6q4yPek2oXWkPTpiKBgd1NcyMcskfzEbwzIfUvGjVKcbLUyM+Eu3ZL
         DhwZdwQ9R4iNF8RAB0s3KrXDyU9uYW+oQk2C4xL+f7y/uUAb+CMSz46dPQEniZVaPmlI
         lgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759080955; x=1759685755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hWHgpM/rb70qd87juqmeSrMZFHqG1itquQCJwHGhEk=;
        b=L6ux2LbFogARET4q80ml8+Ust09A+2BthE+IVPP9aJdPatjdta1oVRzY63E39gXV4c
         40/jgfxd0ivXvqW8NIOjIeeVPpExfZ2B0Jl7U0dp1QsAop5DoQSQqOs028rGzPD9UBrB
         t0+/qpxGDXcA2ROoJe9LaLP33xI9v0M0CHWeU72yGqkKSP/S8yFu9Dv4HNzvbn64lKIl
         F1E87HD/F0fEHtj/bHLGEK1AEO0oh2ucDdfWWJgwAaDNDAUzt6oVm/9FO1926WpIfOhs
         Ku7J53zYxNrPI7/x7pna7MqWA+v8enXr0Q6EsmRE/Qe2IOz5rcLqc7VNJLCrlBlfGlAq
         hIKw==
X-Forwarded-Encrypted: i=1; AJvYcCV+KffKAZnU2cjzrxXZbiKPgU1A09YII4OXWEEbBCuYY37xdrD9K1oe23dHqqye97EGYdGbxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKnp5DSToi9M0AtXzT0e7poXM0MHxPE4q80Vm//cKBcwq9NuYR
	QzShxWTOc57xeYmRQZuropcMFANHlMCSmmxt7rbyG2teG4S37cON0Eum53cVH/peYK6pu/yZjPp
	EDcHC8AGatpSXRHtOnaydSX+fWa6cfdk=
X-Gm-Gg: ASbGncvVH/vxgsxbWnJzqpT40wTaeoVidGk19CWKa/U4sHUGTbGyk6izpMTxbFYEjsZ
	+0iwXSNPqn1ffL3480d8PmOq+tjn3qTLwq+OCtO94RY04jNT4Hzgu5WnY4fiMz5Y37F9XItMDrU
	+kLQ0ovVUmDvwc4SfazF9XsDqtvhNgiHwjSXHwoEPfsFsGBA2vG37nr5W7ybmnBSzQJ03QkmPlU
	Bx7We92nRnd65byXNM=
X-Google-Smtp-Source: AGHT+IF4LtUw7v9U/JYoQT0Wh7nzvSFhJ3UqproTerTY3SiJCa0Vl/rRvk3JMudUZqWnlv9RN4X9SRqdzNlv4OAcKN8=
X-Received: by 2002:a05:6402:352:b0:62f:453c:7235 with SMTP id
 4fb4d7f45d1cf-634ce845b9amr4127811a12.15.1759080955040; Sun, 28 Sep 2025
 10:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1759071169.git.leon@kernel.org> <512d4c498103fcfccd8c60ce1982cd961434d30b.1759071169.git.leon@kernel.org>
In-Reply-To: <512d4c498103fcfccd8c60ce1982cd961434d30b.1759071169.git.leon@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 28 Sep 2025 19:35:43 +0200
X-Gm-Features: AS18NWBtQV3w4fhUJT0qJjc42RZ2Y4lnsCSX8_2AFcicJQutzVlCWs2uQTVZ_oE
Message-ID: <CA+=Fv5SzdR4=NXz68gRg0iXY-6Y=GRsO24UA-DF4tuyJ8r7w7Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] alpha: Convert mapping routine to rely on physical address
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Geoff Levand <geoff@infradead.org>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, 
	iommu@lists.linux.dev, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jason Wang <jasowang@redhat.com>, 
	Juergen Gross <jgross@suse.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	sparclinux@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	virtualization@lists.linux.dev, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 5:02=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Alpha doesn't need struct *page and can perform mapping based on
> physical addresses. So convert it to implement new .map_phys callback.
>
> As part of this change, remove useless BUG_ON() as DMA mapping layer
> ensures that right direction is provided.

After the changes in v1 this runs fine on Alpha. I've tested this on an
ES40 Alphaserver during load (build kernel and unpack tar files).
The v1 patch fixes the errors seen in the first revision of this patch.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
