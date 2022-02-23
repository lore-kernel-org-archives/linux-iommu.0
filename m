Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FB1C433EF
	for <iommu@archiver.kernel.org>; Wed, 23 Feb 2022 17:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24C528141A;
	Wed, 23 Feb 2022 17:45:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id smRWnuh0pZKD; Wed, 23 Feb 2022 17:45:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 192E18139C;
	Wed, 23 Feb 2022 17:45:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0117FC001A;
	Wed, 23 Feb 2022 17:45:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C61EC0011
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 17:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B7D360D74
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 17:45:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3nB8PQ4AdZwa for <iommu@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 17:45:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 827D7600CC
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 17:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645638318; x=1677174318;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=aeb0qt4wCCz7I/mFg9ArXVeLtAeRSHAS90P4rnXgYoM=;
 b=fLaE1VRyF54q4q+9xEdC2RvHffs+9HUjINYIimaRYKqdp7yfkN9fo62I
 poeUUmds354sVOZNctSmR3yVEc4RW6lPJSoC5GX3l+vErRrIGUlDj/8AV
 ZWj/3blCNao8HM+1LPcGhNSiDA1OsgKQDLsJlZvT8aCRGxpZMS/cs8d0n
 nEhxvzOR6+2M7B/gGtJb/NAbfIc3f5lVNZShP/iY1OshI8DqXpQdPTumo
 MAbpqsQaylmVIfKC0JJYFgIdf+b8ZTB0wJqns3IHCj9FKaodooTgXcv1B
 Us7F0fsbtiSpUhie71gaYUvbEaeXOxToYGy5rBQc1DHhuZo4wScEswsjr Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232659135"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; d="scan'208";a="232659135"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2022 09:45:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; d="scan'208";a="491292157"
Received: from chakanog-mobl.amr.corp.intel.com (HELO [10.212.198.215])
 ([10.212.198.215])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2022 09:45:17 -0800
Message-ID: <04080c88-3e69-b4e6-0af2-0690accaa02f@intel.com>
Date: Wed, 23 Feb 2022 09:45:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 00/12] x86: Trenchboot secure dynamic launch Linux
 kernel support
Content-Language: en-US
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, 
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org
References: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
Cc: dpsmith@apertussolutions.com, nivedita@alum.mit.edu, luto@amacapital.net,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, kanth.ghatraju@oracle.com, tglx@linutronix.de,
 trenchboot-devel@googlegroups.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2/16/22 19:54, Ross Philipson wrote:
> The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
> enhance the boot security and integrity in a unified manner. The first area of
> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
> Trust for Measurement). The project has been and continues to work on providing
> a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
> cross-architecture (x86 and Arm), with our recent involvment in the upcoming
> Arm DRTM specification. The order of introducing DRTM to the Linux kernel
> follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
> Technology (TXT) is present today and only requires a preamble loader, e.g. a
> boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
> been present since the introduction of AMD-V but requires an additional
> component that is AMD specific and referred to in the specification as the
> Secure Loader, which the TrenchBoot project has an active prototype in
> development. Finally Arm's implementation is in specification development stage
> and the project is looking to support it when it becomes available.

What problem is this patch series solving?  Is the same problem solved
in a different way in the kernel today?  What is wrong with that
solution?  What effects will end users see if they apply this series?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
