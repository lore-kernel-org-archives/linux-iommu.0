Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769023BE
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573033; cv=none; b=psJnGpvSegUFjc3gv7DHFMcg7Fze/1+OiKMJrzUelYGMVHT32Alzfo0drDr4jFnpjwVT4+0Q/kvIAIJCMzF36kz72HnNQBvulxKdIEsC0iOVCsXNz3yn4DPR6AqevzgGuGzwG12y5yrvlnbT3WyWWJJVuEklYfQynapZPyTQOO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573033; c=relaxed/simple;
	bh=Cu6cOimHwJqoR7VawNoCeLQ/UDK3IeeGCSIVPpFBjWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8MlNNBEpYgNxNaTdWqT8Zn+gs+1OLt8om+26BsV/bW2USDAqR5zoLOUvQQkfvPxJdkQc3u8kPgo836ydGnxJY/yU5CwcbUwNaWEP+KS5rlWwDGATE1gZ9cf8QcWAbCdJUlXedHp3KfxTQH7BtxpiF9SToSQthFp0jBtiKHzR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4iwiX/h; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4iwiX/h"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47681dba807so240831cf.1
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742573031; x=1743177831; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeJPwSaX6HIdUR8KTOVsZ8Feg++HqdiUbFfhCHyoTMI=;
        b=d4iwiX/hQJn+1aNY3BHayhIxhQgKfs2/tAsMJaUDsD/GrGdW964ckJdOSRuXeDzFGM
         cga1l37OsCI/8NrIVamcsVa824Era07PyOUwdAVsZFu/pKqzb6hpjEC915xQvS1sbzIF
         bOHDG89S7mEDETLE69WS4g6jW43zJnXkvI/+PYPwaC/M6fRZa2AjEF3uEShxlWU3Ym9J
         lsWXDvdAOwkRJ6ZOAWtYAa/6CFLULFKR4Vp4WCJdK1aenSqUdKJipJEq/4k6YjkQLTfb
         B+kaX3dQXCBPmS1cwVHFrVSDuhOB1yfaU0hlGIZiJbOWwWu6v7ENkUt43aGfr7RkMcQj
         6AUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573031; x=1743177831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeJPwSaX6HIdUR8KTOVsZ8Feg++HqdiUbFfhCHyoTMI=;
        b=v07uJ64d1spQSqmSn+nR8RqzsqKtcJFdOfb/jUcHKqoajdATZKHUsC6/TeM4Vo7siD
         R5ZV5Z9uC0hJsNOM6fHSrTsyMmwMJayUC9T0e31TsQJnw3sWDRyxVjG6lEHIiPVqjkPN
         24h2rcbulMFZ+d7VqVeYkx0TJb3hk3E9I3kbK+pRUwdy9y2yi1Sq1nfMbdiARCCwYTKZ
         rwO8r2lJ0D4odzckEbGCFAWeeeaJJSqK3g95/ISPrG+lAhJvW0QEJ+S44REn2MCIPMfL
         c1lZBFcfT0QYBHZV2zlf1rsXK1XN/zMDt/cPXjEFEjeQumsBSHwhfEPICzJrlFWxWp6U
         kc0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvjSChd+hgX+OP33218NKXl4k2b4MQUZ4WGu8d2bbAfbORyjUNG0SBQo/IueCxmto4ECaGeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFwkzRjmyTo1k6H2CuSi7CTjiLmKlW7JUL9N4pNCg34pBR8dfC
	mIUNTWkhRkLFlPxXC+iBXgNUx0QxasFkE7PEYOJnRtzTAwMLvgSVi313Uze/3K89Rc0qVKqLN1M
	yMGfDj9gLMjZ1paU44N5HzhxaOT4Y3EUvND7F
X-Gm-Gg: ASbGncsoTtAMnllPPwBAXkQDGqfI1emuWNg8kMu1+oLvSiutrICzMZ6bbMGc/YsTZId
	lzTaxzxjaHIuC7nxnNyXWjXyBswxCDnpbEbDp6lUo28JETugVc/Z/nCHJ8Swbgdq71kLCkYwbfJ
	UIQ+aX6RkFiWocPfjW2y7ujC2jlg==
X-Google-Smtp-Source: AGHT+IFkXczES/4I5kcNrRXzjxrEN1n1yI01ly+4cs5jHTsrsjRGc5j6UaG3BY/6xhutMfdEGFSNPo3rGZczVOmOkmw=
X-Received: by 2002:a05:622a:1f17:b0:466:8887:6751 with SMTP id
 d75a77b69052e-4771f55786emr3998701cf.23.1742573030713; Fri, 21 Mar 2025
 09:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250320173931.1583800-1-surenb@google.com> <20250320173931.1583800-2-surenb@google.com>
 <Z9z1lC9ppphUhDjk@infradead.org>
In-Reply-To: <Z9z1lC9ppphUhDjk@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 21 Mar 2025 09:03:37 -0700
X-Gm-Features: AQ5f1JrBg768vc8VQCwRG29x43voyrYWFfgAzMuHmylUPx3zi7H160snG2PZn8A
Message-ID: <CAJuCfpG9apLCrF0DXjzVtCJoPAa=5BLxArHC6SCKkfPNdpZ1wg@mail.gmail.com>
Subject: Re: [RFC 1/3] mm: implement cleancache
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, liam.howlett@oracle.com, 
	alexandru.elisei@arm.com, peterx@redhat.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, m.szyprowski@samsung.com, iamjoonsoo.kim@lge.com, 
	mina86@mina86.com, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, hbathini@linux.ibm.com, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, aneesh.kumar@kernel.org, 
	bhelgaas@google.com, sj@kernel.org, fvdl@google.com, ziy@nvidia.com, 
	yuzhao@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:14=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, Mar 20, 2025 at 10:39:29AM -0700, Suren Baghdasaryan wrote:
> > Cleancache can be thought of as a page-granularity victim cache for cle=
an
>
> Please implement your semantics directly instea of with a single user
> abstraction.  If we ever need an abstraction we can add it once we have
> multiple consumers and know what they need.

If after the conference no other users emerge I will fold it into
GCMA. That's quite easy to do.
Thanks,
Suren.

>
