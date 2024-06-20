Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F181B582C
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908347; cv=none; b=tX1yXfZEwncpeBCp3ITxpPHyQF1EE8iXMsH1F4bvsz6vfEy56xdII9xsMq9NOYJys0hn/FdDyO/UVi5St5YZBs2U3v7sVSCeYZ3ywbIWpXWQzS0dlXxVWH7xlK+ytajRrkDCMqvd2H5C4aJdMMA+dqyNLVS5NXvbTJeAqAvczro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908347; c=relaxed/simple;
	bh=bcnNV5dpAp1ceLCDW/J9hztLgbbtYChtelB1u6t4YSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qnd3fnhBfi4H87p5+0kk9tB+80VnxgTHwHf2Vzo7uPh/JSH1QvqMmhnBmfMKbXC7ASAlD02xzK2GeG6Av2SaCjZSp1spfKraMnNSJEHK6r3d+N5YkzvMscEf9VqwXpoF6Xyg6sOCAFzOLi/AddNfGics4+nozE7kzeU0MvqVM0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it1Rik8C; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it1Rik8C"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f44b594deeso10679485ad.2
        for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718908345; x=1719513145; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8iVi8v7MOsNpmY/+YQC9/JqsYXXSSMQtfI1oW5IIrXg=;
        b=it1Rik8CgvCUivky5LVmvwj/4x1MGsGmeyMIiqJbdsBLGn7f+rNzemwrF4Vb6jO3jK
         XZdT/U+VKFXgFwkvH8C1+6OTfOBuna9fP2h4uBRVJyZ8Z0uBUqaYeYCrX3VfqdFLOom7
         f0tV3sM0zyZXorYonFSCuEcfZu98FINcB2RIkGkagX/3tweXzNdI/FasT/NnQjh2IJf5
         ihiXClHGt9be+MmGQgTxk81eMVqv7wMdJ8YcQt3O37odjZjqRcpsJXBGgiHkkHaXQf3g
         jk1qlOlnUsAIUaQiefWA89Vf3MEXpDECYsU6xQ6r3QrS8PZ4JD8+wS+TMpWIbaLPr0vV
         HvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718908345; x=1719513145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iVi8v7MOsNpmY/+YQC9/JqsYXXSSMQtfI1oW5IIrXg=;
        b=xEt/CTMltWmpsq1dANC5KK5kGj99R1/irCCfBoxrU4u9c9LhdgEqh/9/2JdjtQvimx
         c72iO3tQHL7hUptSyIQ5/6wTZe4JYYvsvbreA39Yg1RR36ppKjnKLlTaO/7UicrnkFZu
         xksFKACEeFDiQXcfieoe8CzinvmGdQJuZur8KL6T/dNJzdXRG2gn3dXMO/NyLN6Ces1M
         1CZqTCfxYTkI84xOyXAK+9SAkQN3k1B6dQIkbk6EnwXvZLyWmyZWqp4CqMD1I/5A2tB2
         0KF+IhZu8cEbFwOox1oFC7zOPwLvkpPVAv0Z9tWw7aQDZvYIDPYz+8xF0qefRrsC+FRn
         HorA==
X-Forwarded-Encrypted: i=1; AJvYcCUjfADqkY+HC3ysLnNNjJptuEWmiecZ/LVwyjBK2Os186yqIL8uIBQh4fQQsjR4YKEyfoHU8kwHkc8KjEZgOELdmPxG2Kg=
X-Gm-Message-State: AOJu0YyKHtZ35icQB3qQBOaXkeCij+6DToQDFa6gab0l+0/4SY7COf7/
	xzxMZnsCekeKd3SawJ3zAfTaBupWqsNVYZiQwalm8ZsaeWdFtO69
X-Google-Smtp-Source: AGHT+IGwYt1/AWmTgUMNjVMcs2dgiLwPkNhT8ZohuoeI/pLSbMfw85UksxqJbsocMe0+kY+O1HneTA==
X-Received: by 2002:a17:903:230c:b0:1f9:bb35:f313 with SMTP id d9443c01a7336-1f9bb35f5b7mr46779535ad.30.1718908344747;
        Thu, 20 Jun 2024 11:32:24 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e80ef6sm140498555ad.115.2024.06.20.11.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 11:32:23 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:32:21 -0700
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
Message-ID: <ZnR1tQN01kN97G_F@yury-ThinkPad>
References: <20240620175703.605111-1-yury.norov@gmail.com>
 <CAHk-=wiUTXC452qbypG3jW6XCZGfc8d-iehSavxn5JkQ=sv0zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiUTXC452qbypG3jW6XCZGfc8d-iehSavxn5JkQ=sv0zA@mail.gmail.com>

On Thu, Jun 20, 2024 at 11:00:38AM -0700, Linus Torvalds wrote:
> On Thu, 20 Jun 2024 at 10:57, Yury Norov <yury.norov@gmail.com> wrote:
> >
> >
> > The typical lock-protected bit allocation may look like this:
> 
> If it looks like this, then nobody cares. Clearly the user in question
> never actually cared about performance, and you SHOULD NOT then say
> "let's optimize this that nobody cares about":.
> 
> Yury, I spend an inordinate amount of time just double-checking your
> patches. I ended up having to basically undo one of them just days
> ago.

Is that in master already? I didn't get any email, and I can't find
anything related in the master branch.

> New rule: before you send some optimization, you need to have NUMBERS.

I tried to underline that it's not a performance optimization at my
best. People notice some performance differences, but it's ~3%, no
more.

> Some kind of "look, this code is visible in profiles, so we actually care".

The original motivation comes from a KCSAN report, so it's already
visible in profiles. See [1] in cover letter. This series doesn't fix
that particular issue, but it adds tooling that allow people to search
and acquire bits in bitmaps without firing KCSAN warnings.

This series fixes one real bug in the codebase - see #33, and
simplifies bitmaps usage in many other places. Many people like
it, and acked the patches.

Again, this is NOT a performance series.

Thanks,
Yury

> Because without numbers, I'm just not going to pull anything from you.
> These insane inlines for things that don't matter need to stop.
> 
> And if they *DO* matter, you need to show that they matter.
> 
>                Linus
