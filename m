Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC23C433FE
	for <iommu@archiver.kernel.org>; Thu,  2 Dec 2021 17:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 989C96F4BF;
	Thu,  2 Dec 2021 17:26:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y-4cTqaz1CL5; Thu,  2 Dec 2021 17:26:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8F0D661CF6;
	Thu,  2 Dec 2021 17:26:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7891FC001C;
	Thu,  2 Dec 2021 17:26:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 670CAC000A
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 17:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55A9F6F4BB
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 17:26:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WgS_6gquabAU for <iommu@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 17:26:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C5EA61CF6
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 17:26:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72E80142F;
 Thu,  2 Dec 2021 09:26:26 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 350B63F73B;
 Thu,  2 Dec 2021 09:26:24 -0800 (PST)
Message-ID: <bd677501-bd65-9648-c8f5-1b90983377b5@arm.com>
Date: Thu, 2 Dec 2021 17:26:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4 04/14] Documentation/x86: Secure Launch kernel
 documentation
Content-Language: en-GB
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, 
 x86@kernel.org, iommu@lists.linux-foundation.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
 <1630070917-9896-5-git-send-email-ross.philipson@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1630070917-9896-5-git-send-email-ross.philipson@oracle.com>
Cc: dpsmith@apertussolutions.com, luto@amacapital.net, mingo@redhat.com,
 kanth.ghatraju@oracle.com, hpa@zytor.com, bp@alien8.de, tglx@linutronix.de,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-08-27 14:28, Ross Philipson wrote:
[...]
> +IOMMU Configuration
> +-------------------
> +
> +When doing a Secure Launch, the IOMMU should always be enabled and the drivers
> +loaded. However, IOMMU passthrough mode should never be used. This leaves the
> +MLE completely exposed to DMA after the PMR's [2]_ are disabled. First, IOMMU
> +passthrough should be disabled by default in the build configuration::
> +
> +  "Device Drivers" -->
> +      "IOMMU Hardware Support" -->
> +          "IOMMU passthrough by default [ ]"
> +
> +This unset the Kconfig value CONFIG_IOMMU_DEFAULT_PASSTHROUGH.

Note that the config structure has now changed, and if set, passthrough 
is deselected by choosing a different default domain type.

> +In addition, passthrough must be disabled on the kernel command line when doing
> +a Secure Launch as follows::
> +
> +  iommu=nopt iommu.passthrough=0

This part is a bit silly - those options are literally aliases for the 
exact same thing, and furthermore if the config is already set as 
required then the sole effect either of them will have is to cause "(set 
by kernel command line)" to be printed. There is no value in explicitly 
overriding the default value with the default value - if anyone can 
append an additional "iommu.passthrough=1" (or "iommu=pt") to the end of 
the command line they'll still win.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
