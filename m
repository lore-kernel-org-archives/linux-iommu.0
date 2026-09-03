Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA3B4A6CF3
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440784; cv=none; b=LV76Mf5hHG43vHJ75Jazz7KZnU3SxCbvEsQylnZcNpijQOwORbuIW4ameQpzej2DTl1c8RCeNG4x+u9S2G+H+ae1xishFSUY/fdAcV7G2Ky1y6k062LGcundVsO7QDpk1FppHv3hADRTc7MUbnr9Aprq7or5pO4ozkwEr3Z0JeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440784; c=relaxed/simple;
	bh=mRADvc7owSNp8BD4ZGoL+3L92JnEfsnptUTwuMKTZG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ato1p4HMEIW28V+M62FpfyoElvdkbEPIPuZMXJE4CTSZFJYUKqiYLLFX5xz5WQ/AeefygUBwnGyQe9oBTqfvBFIRYayuuiK2DStIrYi5vAwNn6n1n/oQL6myzklqFGwQfN1bskUdDR1scZEKW3S9+6R80jO5vUTh3l3jQV1hmNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=NUqAquQb; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="NUqAquQb"
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 86FBAA056B;
	Thu,  3 Sep 2026 13:05:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 452DD6000D;
	Thu,  3 Sep 2026 13:05:53 +0000 (UTC)
Date: Thu, 3 Sep 2026 09:06:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, Mathias Nyman <mathias.nyman@intel.com>,
 linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [BUG v7.3-rc1] WARNING: mm/page_alloc.c:5340 at
 __alloc_frozen_pages_noprof
Message-ID: <20260903090656.530d3a83@gandalf.local.home>
In-Reply-To: <41737353-533e-4d50-b687-272e6cbde36a@linux.intel.com>
References: <20260902143351.7b6d5e0a@gandalf.local.home>
	<20260903091556.751544ce.michal.pecio@gmail.com>
	<41737353-533e-4d50-b687-272e6cbde36a@linux.intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 16p4qrn9es8piidh7su613o58twi596w
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 452DD6000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19zcYgJKv9Ftc3sD1tas6mugxLkUfwT9Vo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=38a4Bf5YB5LQTRVyVKPjbsQNu5q3FotJKzq+IHm8WY0=; b=NUqAquQbfIQamKtVtqFIrcP9v9wRdRhAJaHZn2ajhW5A+sd9qYHxVzGioBsCw5EgDjZAPIG5ZLUeWb4Ec+g+JMS9OSlchxuAcFwfd7F8szvAdZsLqZ+mMXdgtATp3EwKXUXEFAvf0Zya2pPMOHC+LX8O9FZt/fE5HYQzSKqWjr8=
X-HE-Tag: 1788440753-441833
X-HE-Meta: U2FsdGVkX18aw29kfpPNquKlLhGFjQ8pcsecgrC3FsqwcNTkHseIBqi9DR6+Nd+DE+feFEvS6WA4Sj1Wvrb7qxTtGUAkrDo8bbriUZx8JEI85n8TkUMB7SFhFgvsqd1pOroApqfV7xw+ggQVPuxxZ60lyCymH3IZ+Dh8QnR1aQ5eqXTUMYZuEgyYo4tRVZ53r0HAeTDTe24bd7RuZjycfUb9026/pWyRj/m17lF5SZo2lQMk/cI1sw0+aCvCiabtekOOKDKFh+fVG39ZResESwBee+xTn4aJj7MXtfCgaCRrRXk08iiZ39GSPWcdeQX5yKzUtc9kF6nQmwUvKa+lESyHj6PGpNHCEfasrjhMuFby+LHlgQ3sxOkqgByFpo/q8Syz7HK7nmFm3HQxjXG3DO3rn88NiY7Ieg2PL32VCqg=

On Thu, 3 Sep 2026 11:32:33 +0300
Mathias Nyman <mathias.nyman@linux.intel.com> wrote:

> On 9/3/26 10:15, Michal Pecio wrote:
> > On Wed, 2 Sep 2026 14:33:51 -0400, Steven Rostedt wrote:  
> >> I'm triggering this warning on boot:
> >>
> >> [   32.862044] ------------[ cut here ]------------
> >> [   32.864573] WARNING: mm/page_alloc.c:5340 at __alloc_frozen_pages_noprof+0xd81/0x30d0, CPU#3: swapper/0/1  
> > 
> > Apparently that's a nonsense allocation size.
> >   
> >> [   32.881048] Modules linked in:
> >> [   32.883735] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc1-test #510 PREEMPT(full)
> >> [   32.890178] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014  
> > 
> > Hmm, I recall hearing about QEMU recently.
> > 
> > Could this be the "horrible splat" mentioned by 045b5bef916d ?
> > 
> > Find it in usb-linus branch at
> > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> >   
> Yes, this is the case
> 
> A patch switching to GENMASK and FIELD_GET has a flaw and changed the parsing of
> the max segments value reported by xHCI host controller.
> 
> xHC returns _exponent_ of maximum segments supported, QEMU supports one segment
> so value read is 0.  Parsing fails and assumes maximum number of supported ring segments
> is 0.  Most hardware xHCI controllers (except some Mediatek) support more than one
> segments so issue is not visible for those
> 
> Issue (7.3-rc1):
> 6d45e9556d4a  ("usb: xhci: standardize multi bit-field macros") in parsing
> 
> Fix: (in Greg's tree, Hopeful it can make make 7.3-rc2)
> 045b5bef916d usb: xhci: Fix HCS_ERST_MAX conversion

I applied the above fix to my tree and sure enough the warning goes away.

Tested-by: Steven Rostedt <rostedt@goodmis.org>

Thanks!

-- Steve
