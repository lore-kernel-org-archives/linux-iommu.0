Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394501B4C25
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914825; cv=none; b=uiW8fucdSQ7ZUaoGtYQukIbgOClPBC/6/I60F882NCU0KNX7iRYLxgHy0YjgkoN0fN0NKSScR3Nlore/r6ozRMASWacqKuck3UPgloDG8bpBp9IvgNzfvH2luS18rpetQRWCD67AbCLXYSlg4QWXkGET2+uimBGhr2JQxf1lqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914825; c=relaxed/simple;
	bh=rBq7IdJM+K+0+xUcWM1SpeYU9dZrL3Z/PWGHq/TQFvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSRzNSHPPr+ZTvjq4aWqdUVgLUScG0IwfpJKRivATIxsGMj4uK1IDmVCev0eXxYZ0ns7qM2FIMY2M0e3DLfhsXDX0kITql5YCRMzYvUgIx5VBZbEO4aqNKpH7r+Bc4mQSwCTgNV2Stidwn9HgyLQ6ZVBWeRhnRcr583kDDH+q7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCkIEHEO; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCkIEHEO"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-70df213542bso928134a12.3
        for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718914823; x=1719519623; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyF3zFimLRvnxw2fNLWvvt4TaZ4/tRThw/CSNxiuI4k=;
        b=lCkIEHEOyMiekuuVP9H5BYAK1FXFwZN8HQOMpactAnnrI0lOhUjBSdzm1zbkjaCBqc
         CjQU140VCAdFlRrCQ71xnT6ohteP+0HnI3FiB0jfGIpesAVZKsSc8iJd2uUhYUM7eW52
         TH8Tzmay3Z8x47feT45+oqg0eVWHmnqkU59pVZdPiiKjxc53oUusJ4yheX+Cvwznyvz5
         Oxup6gz3WHkZ69bgOffVBd0H8/bJL4udvTn7ZpePn80CGPAITfjBgTyapDTZJWAZtSII
         7n4M1Lc+AZDN8K+pvLk8uuN7iQtXYq9+tBEetkbKM2AmHkkc59FFewm69sy82nyCb9AW
         81PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718914823; x=1719519623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyF3zFimLRvnxw2fNLWvvt4TaZ4/tRThw/CSNxiuI4k=;
        b=sD0PEHIMD/5kOA2cKE3DTY0H4C76Wm8NgqdQHkYxH99dbNy4EsmxEyjLrjMgOxmUVQ
         vosH8EPNk5SplvcGPMm4mwRBm3pikd4zKo3smBAYCvM3UxY/cqyR80tZan2SyfkyQv3B
         YwDAL1axECrXtRnqvj/+RG2GBRyMKSZcAnJFJiS03NmygDD0nc1VrX2LAHrblOimU0yb
         CBzcodNrLp2Xb2KnqVTmv2AqHatSaa/I+D1cy2j+OWOfFHGV/OOupc13TEXntXTn7j1Q
         YoId4pWNacWsnFr7MtoasyFHLNMKCvDtzg/hyEJJPjEp92tL8hhN9UFAGpsAYzNH4BeP
         934g==
X-Forwarded-Encrypted: i=1; AJvYcCXpMYxbi+ivCZUZ5y8A1CzLV5STk5kSU4HN4PKDQp9WYCfJl33TpBStZZgPxk/PQn9XMUvQPNsEJEQmfoyYZyuxnK3k/MU=
X-Gm-Message-State: AOJu0YxpIlGRvQHkOnrtCd6I4ob8bs4pwVzNMKsUJ1T3gHYqm3mO2JIL
	7tPnM2dNy8K0qNF3KnY9MIdIfnDk+uTa/oaNiUSPNx94fiEd3i9M
X-Google-Smtp-Source: AGHT+IHgTaUdNjnFlceuqDZQb86IcFDSmpZVDJyq9iZqJozpl3uONt9e5qvEXl/03kBUwqlpGmD+xQ==
X-Received: by 2002:a17:90b:3ec6:b0:2c7:e420:a0ec with SMTP id 98e67ed59e1d1-2c7e420a3f5mr3603638a91.0.1718914823251;
        Thu, 20 Jun 2024 13:20:23 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819dcc704sm81988a91.47.2024.06.20.13.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 13:20:22 -0700 (PDT)
Date: Thu, 20 Jun 2024 13:20:20 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Disseldorp <ddiss@suse.de>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Hans de Goede <hdegoede@redhat.com>,
	Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
	Jiri Pirko <jiri@resnulli.us>, Jiri Slaby <jirislaby@kernel.org>,
	Kalle Valo <kvalo@kernel.org>, Karsten Graul <kgraul@linux.ibm.com>,
	Karsten Keil <isdn@linux-pingi.de>,
	Kees Cook <keescook@chromium.org>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Oliver Neukum <oneukum@suse.com>, Paolo Abeni <pabeni@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ping-Ke Shih <pkshih@realtek.com>, Rich Felker <dalias@libc.org>,
	Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	GR-QLogic-Storage-Upstream@marvell.com, alsa-devel@alsa-project.org,
	ath10k@lists.infradead.org, dmaengine@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-net-drivers@amd.com, linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, mpi3mr-linuxdrv.pdl@broadcom.com,
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v4 00/40] lib/find: add atomic find_bit() primitives
Message-ID: <ZnSPBFW5wL0D0b86@yury-ThinkPad>
References: <20240620175703.605111-1-yury.norov@gmail.com>
 <CAHk-=wiUTXC452qbypG3jW6XCZGfc8d-iehSavxn5JkQ=sv0zA@mail.gmail.com>
 <ZnR1tQN01kN97G_F@yury-ThinkPad>
 <CAHk-=wjv-DkukaKb7f04WezyPjRERp=xfxv34j5fA8cDQ_JudA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjv-DkukaKb7f04WezyPjRERp=xfxv34j5fA8cDQ_JudA@mail.gmail.com>

On Thu, Jun 20, 2024 at 12:26:18PM -0700, Linus Torvalds wrote:
> On Thu, 20 Jun 2024 at 11:32, Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Is that in master already? I didn't get any email, and I can't find
> > anything related in the master branch.
> 
> It's 5d272dd1b343 ("cpumask: limit FORCE_NR_CPUS to just the UP case").

FORCE_NR_CPUS helped to generate a better code for me back then. I'll
check again against the current kernel.

The 5d272dd1b343 is wrong. Limiting FORCE_NR_CPUS to UP case makes no
sense because in UP case nr_cpu_ids is already a compile-time macro:

#if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
#define nr_cpu_ids ((unsigned int)NR_CPUS)
#else
extern unsigned int nr_cpu_ids;
#endif

I use FORCE_NR_CPUS for my Rpi. (used, until I burnt it)

> > > New rule: before you send some optimization, you need to have NUMBERS.
> >
> > I tried to underline that it's not a performance optimization at my
> > best.
> 
> If it's not about performance, then it damn well shouldn't be 90%
> inline functions in a header file.
> 
> If it's a helper function, it needs to be a real function elsewhere. Not this:
> 
>  include/linux/find_atomic.h                  | 324 +++++++++++++++++++
> 
> because either performance really matters, in which case you need to
> show profiles, or performance doesn't matter, in which case it damn
> well shouldn't have special cases for small bitsets that double the
> size of the code.

This small_const_nbits() thing is a compile-time optimization for a
single-word bitmap with a compile-time length.

If the bitmap is longer, or nbits is not known at compile time, the
inline part goes away entirely at compile time.

In the other case, outline part goes away. So those converting from
find_bit() + test_and_set_bit() will see no new outline function
calls.

This inline + outline implementation is traditional for bitmaps, and
for some people it's important. For example, Sean Christopherson
explicitly asked to add a notice that converting to the new API will
still generate inline code. See patch #13.
