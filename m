Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD74C4741F
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 05:31:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96522085B
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 05:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96522085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0097886B98;
	Fri, 25 Sep 2020 05:30:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9jvqpYLPFOKR; Fri, 25 Sep 2020 05:30:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 36E8286B92;
	Fri, 25 Sep 2020 05:30:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D79AC0859;
	Fri, 25 Sep 2020 05:30:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76226C0051
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 05:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5F0FE86B92
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 05:30:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ijZ8sBGo8uyw for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 05:30:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8C9E286B90
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 05:30:57 +0000 (UTC)
IronPort-SDR: H338fofG2REQizAidKd7/HrnLCQQk+n0m5QcVShshILyeIVeNn7FLCQxYVmMbHtiVZGfCSYm+M
 OC3YThroGvIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="140862513"
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; d="scan'208";a="140862513"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 22:30:56 -0700
IronPort-SDR: WHC8TVpRPckTyme5K4pR2/mKS9uladFAgCqeF3TUhnY+DIiX0PVqaAxDdiRV3gA/ZlPqnbyqEt
 T2o5VBueKJWA==
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; d="scan'208";a="487315674"
Received: from erybin-mobl.ccr.corp.intel.com (HELO localhost)
 ([10.249.47.248])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 22:30:53 -0700
Date: Fri, 25 Sep 2020 08:30:51 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Ross Philipson <ross.philipson@oracle.com>
Subject: Re: [PATCH 00/13] x86: Trenchboot secure dynamic launch Linux kernel
 support
Message-ID: <20200925053051.GA165011@linux.intel.com>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: linux-doc@vger.kernel.org, dpsmith@apertussolutions.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, luto@amacapital.net,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, linux-integrity@vger.kernel.org,
 trenchboot-devel@googlegroups.com, tglx@linutronix.de
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

On Thu, Sep 24, 2020 at 10:58:28AM -0400, Ross Philipson wrote:
> The Trenchboot project focus on boot security has led to the enabling of
> the Linux kernel to be directly invocable by the x86 Dynamic Launch
> instruction(s) for establishing a Dynamic Root of Trust for Measurement
> (DRTM). The dynamic launch will be initiated by a boot loader with

What is "the dynamic launch"?

> associated support added to it, for example the first targeted boot
> loader will be GRUB2. An integral part of establishing the DRTM involves
> measuring everything that is intended to be run (kernel image, initrd,
> etc) and everything that will configure that kernel to run (command
> line, boot params, etc) into specific PCRs, the DRTM PCRs (17-22), in
> the TPM. Another key aspect is the dynamic launch is rooted in hardware,
> that is to say the hardware (CPU) is what takes the first measurement
> for the chain of integrity measurements. On Intel this is done using
> the GETSEC instruction provided by Intel's TXT and the SKINIT
> instruction provided by AMD's AMD-V. Information on these technologies
> can be readily found online. This patchset introduces Intel TXT support.

Why not both Intel and AMD? You should explain this in the cover letter.

I'd be more motivated to review and test a full all encompassing x86
solution. It would increase the patch set size but would also give it
a better test coverage, which I think would be a huge plus in such a
complex patch set.

> To enable the kernel to be launched by GETSEC, a stub must be built
> into the setup section of the compressed kernel to handle the specific
> state that the dynamic launch process leaves the BSP in. This is
> analogous to the EFI stub that is found in the same area. Also this stub

How is it analogous?

> must measure everything that is going to be used as early as possible.
> This stub code and subsequent code must also deal with the specific
> state that the dynamic launch leaves the APs in.

What is "the specific state"?

> A quick note on terminology. The larger open source project itself is
> called Trenchboot, which is hosted on Github (links below). The kernel
> feature enabling the use of the x86 technology is referred to as "Secure
> Launch" within the kernel code. As such the prefixes sl_/SL_ or
> slaunch/SLAUNCH will be seen in the code. The stub code discussed above
> is referred to as the SL stub.

Is this only for Trenchboot? I'm a bit lost. What is it anyway?

> The basic flow is:
> 
>  - Entry from the dynamic launch jumps to the SL stub
>  - SL stub fixes up the world on the BSP

What is "SL"?

>  - For TXT, SL stub wakes the APs, fixes up their worlds
>  - For TXT, APs are left halted waiting for an NMI to wake them
>  - SL stub jumps to startup_32
>  - SL main runs to measure configuration and module information into the
>    DRTM PCRs. It also locates the TPM event log.
>  - Kernel boot proceeds normally from this point.
>  - During early setup, slaunch_setup() runs to finish some validation
>    and setup tasks.

What are "some" validation and setup tasks?

>  - The SMP bringup code is modified to wake the waiting APs. APs vector
>    to rmpiggy and start up normally from that point.
>  - Kernel boot finishes booting normally
>  - SL securityfs module is present to allow reading and writing of the
>    TPM event log.

What is SL securityfs module? Why is it needed? We already have
securityfs file for the event log. Why it needs to be writable?

>  - SEXIT support to leave SMX mode is present on the kexec path and
>    the various reboot paths (poweroff, reset, halt).

What SEXIT do and why it is required on the kexec path?

/Jarkko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
