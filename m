Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269C7125C5
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 23:55:27 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1b4fe2139a8so44725ad.1
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 16:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686786927; x=1689378927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cp8A+EkiL0VYJVNToeqPquceOf+WVhmFookr8OmaRSM=;
        b=Pf4mNAMn9dp36uBXyHz5uNXAjSQ4WYXHKBb2JMlBKTTRzb2BLWNto0F8B2d2/+tVBB
         IISvciJ6L2DBe+qRhbWFmtkLfrflUm/aUmxcEfxGIwEUPNPUb2rfS9cnniqVH3GNjo5u
         JELvww7og3gzZyrQzIJfpYaMKrhKTNlk7n/q9e5KAxJAklyLW8Kiyed8IiqRv4thceR3
         Ale9dLKP8uUuLq/J8kt95IcPg1U+DE0y+l0FjjcShQZ/aErLILik0i5/r+nytzfRPAgd
         4Y9+M6DlE4l/z/Ty3v6/aY48Ov8bOB2pMIngjCGP5oGtmY5bpI2jbrEDOzqPLWRFyXZC
         tTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686786927; x=1689378927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp8A+EkiL0VYJVNToeqPquceOf+WVhmFookr8OmaRSM=;
        b=aVCFypjLH9s5VXAY8O0zHPDuLZ7nWmwPn9dpK+q5BZRXLKqgRm+Tp3n/O7Hbi/NDiz
         pPkOeKZI0yAHX+gEjSyzPZ5tqHgFVDmnNbG8WydoLfhmnNCmAAKe1RCHyuf9p+le75iX
         V0SWm8g2a9TA0nOMraMrsc2WdZzUczap00l9BuyB2stlUP3vw9K9qxYs7YG3GXp0H/aR
         ANLo0iJN4ev6cbZ6nDmINdEntKDZNtn6KONawkRCMnyL2DiEe2TaUMfXTHrFFOkAZR8d
         e8+6wlaYlz25rDvR8SMCJnyWGhOsgkQI512nyOJdg2wItKL7x3xX8npq+BZVpeUU/ba6
         /qLA==
X-Gm-Message-State: AC+VfDyrL9nGB/Tm58KHpRRdNOZmpsPfNj41PfiIecAYgLarIX5++UJM
	Tc50bM5KqfJy8KiHyDeqZ91uIw==
X-Google-Smtp-Source: ACHHUZ4LZ3tbRG7AocVYuv1WtNna6ocaxw45maUfrbQyz+pehk7SJKYGZchCEC1ssOUIwjWnOtBZrg==
X-Received: by 2002:a17:903:5cb:b0:1b0:4687:ba19 with SMTP id kf11-20020a17090305cb00b001b04687ba19mr108329plb.10.1686786927017;
        Wed, 14 Jun 2023 16:55:27 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:ac7a:bf2e:1950:e94c])
        by smtp.gmail.com with ESMTPSA id b17-20020aa78111000000b006542e358721sm10853520pfi.186.2023.06.14.16.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 16:55:26 -0700 (PDT)
Date: Wed, 14 Jun 2023 16:55:21 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Tomonori Fujita <tomonori.fujita@ntt.com>,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v6 00/17] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to
 8
Message-ID: <ZIpTafmE2r9sA5EV@google.com>
References: <20230531154836.1366225-1-catalin.marinas@arm.com>
 <CABfwK12_wC1t5J9c8qRmUi9H4GtYc6KR9oeJPi8ucK36prhUzQ@mail.gmail.com>
 <CAMj1kXHP_57EOOYQtuL2NO9=7sHPxrX=c0ayYwHaYx9x9hxhJw@mail.gmail.com>
 <ZIJISbauzCR/oKby@google.com>
 <20230609101156.6f17e3c6@meshulam.tesarici.cz>
 <TYWPR01MB101127656AB0A0D5DB1FF4CB3F354A@TYWPR01MB10112.jpnprd01.prod.outlook.com>
 <20230612074755.GA24234@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612074755.GA24234@lst.de>

On Mon, Jun 12, 2023 at 09:47:55AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 12, 2023 at 07:44:46AM +0000, Tomonori Fujita wrote:
> > I cannot recall the patch but from quick look, moving trace_swiotlb_bounced() to
> > swiotlb_tbl_map_single() makes sense.
> 
> Agreed.

There's actually two call-sites for trace_swiotlb_bounced():
swiotlb_map() and xen_swiotlb_map_page(). Both those functions
also invoke swiotlb_tbl_map_single(), so moving the call to
trace_swiotlb_bounced() to swiotlb_tbl_map_single() means that
there will be 2 traces per bounce buffering event.

The difference between the two call-sites of trace_swiotlb_bounced()
is that the call in swiotlb_map() uses phys_to_dma() for the device
address, while xen_swiotlb_map_page() uses xen_phys_to_dma().

Would it make sense to move the trace_swiotlb_bounced() call to
swiotlb_tbl_map_single() and then introduce a
swiotlb_tbl_map_single_notrace() function which doesn't do the tracing,
and xen_swiotlb_map_page() can call this?

--Isaac
