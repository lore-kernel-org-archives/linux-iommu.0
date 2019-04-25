Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AE5C10F03
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:10:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E294206BA
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAxXHkZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E294206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 131FE1C67;
	Thu, 25 Apr 2019 10:10:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9B6E51C2E
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 10:09:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
	[209.85.128.49])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 275D882B
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 10:09:39 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id h11so2902499wmb.5
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 03:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=qDXe8aInWx7rrUFbUzdCjPGqVvpdtP3z9EWwVfzbZc0=;
	b=kAxXHkZYy9zXKuU1mD/GV24mrHOTRf2dSE1dytqyDTE9UDI6Qs03UeV4nB5Yquf+nl
	1tep2U7T3Sryt2ngffH0HbGnWoldhLQYMgCmjjSkzwRogMPhe3prjnuLu6GRBIQdgUmP
	FO9A7NNqPP+fSPIriO0PBVmQlihNr+lRUE9kN3TizxGphIMjD0dAZh3pX8+TVTBIlEGM
	NvtAJ9V68fpOVi2Lsx5HMiib5OaOfiymoKlY6eqWti6BEHTZMF6SWGNJ9IBt5/IKPWow
	QfTd69DVj5A06mVnuB2nERuOjY3Jq4M3TbOja1rBzuWUVL+Z+FGC8ZLEkNP4i5JfSmzV
	aAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=qDXe8aInWx7rrUFbUzdCjPGqVvpdtP3z9EWwVfzbZc0=;
	b=VOd1hijZHDznRI64sPR4YwFBuABYeGELqKfzNqLUj1Xv764lVuWuLUFCPcOpbVTHH9
	NltsxcaMGXg5fe1YMkqn6Pn8UzANEavajp2wnDEX1eol6XzCTgbsaGqVtHH7k0zOJDLo
	CrwkED2ZAzcrINty73b2mqhx4dEtT48f/u8j9tAib/Ke9Pza6RnlsbVMl5/JiWoLa+N4
	v/DWUhcrAIr2aIPbvjYkfQ3th2WfRSXv+ZQGb1Kl2xfzAt8jJXLP7lpq5xUGtH6ewOav
	yjHQ4XWinUqSqecL9mv0C4I9nrBNkhV91E/In7Vq/qfimnqVxw9yxlhrR1Fm+iIOIdR1
	5YfA==
X-Gm-Message-State: APjAAAUYogmM83eQGl254sjS7cFmCw0YadmZwHfEZi7V677ABqAI8+ct
	Ar1u7cnUhGbjNKqzy+CR1Rg=
X-Google-Smtp-Source: APXvYqx2GAh1uv+m48koOKK3YSqfB/7bnkVhISaxrxFGwOyRBo5NQ9XpO4CFxCAJqjHa83cweimVmQ==
X-Received: by 2002:a1c:6c04:: with SMTP id h4mr2890302wmc.135.1556186977884; 
	Thu, 25 Apr 2019 03:09:37 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
	by smtp.gmail.com with ESMTPSA id
	c2sm19739225wrr.13.2019.04.25.03.09.35
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 03:09:37 -0700 (PDT)
Date: Thu, 25 Apr 2019 12:09:33 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 00/29] stacktrace: Consolidate stack trace usage
Message-ID: <20190425100933.GB8387@gmail.com>
References: <20190425094453.875139013@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190425094453.875139013@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mike Snitzer <snitzer@redhat.com>, David Airlie <airlied@linux.ie>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	dm-devel@redhat.com, Alexander Potapenko <glider@google.com>,
	Christoph Lameter <cl@linux.com>,
	Miroslav Benes <mbenes@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Alasdair Kergon <agk@redhat.com>, linux-arch@vger.kernel.org,
	x86@kernel.org, kasan-dev@googlegroups.com,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexey Dobriyan <adobriyan@gmail.com>, intel-gfx@lists.freedesktop.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, Josef Bacik <josef@toxicpanda.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	David Sterba <dsterba@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
	Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org,
	Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-btrfs@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190425100933.m8bVaiAepF0KIeLDommOIjvCeZEzfyUl-cI0mK082mw@z>


* Thomas Gleixner <tglx@linutronix.de> wrote:

> -	if (unlikely(!ret))
> +	if (unlikely(!ret)) {
> +		if (!trace->nr_entries) {
> +			/*
> +			 * If save_trace fails here, the printing might
> +			 * trigger a WARN but because of the !nr_entries it
> +			 * should not do bad things.
> +			 */
> +			save_trace(trace);
> +		}
>  		return print_circular_bug(&this, target_entry, next, prev);
> +	}
>  	else if (unlikely(ret < 0))
>  		return print_bfs_bug(ret);

Just a minor style nit: the 'else' should probably on the same line as 
the '}' it belongs to, to make it really obvious that the 'if' has an 
'else' branch?

At that point the condition should probably also use balanced curly 
braces.

Interdiff looks good otherwise.

Thanks,

	Ingo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
