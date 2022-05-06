Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31263C433EF
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 21:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D394D40590;
	Fri,  6 May 2022 21:32:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wAGWjEBc2KMN; Fri,  6 May 2022 21:32:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D2C04400B8;
	Fri,  6 May 2022 21:32:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2F76C0039;
	Fri,  6 May 2022 21:32:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C0B6C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 21:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 43F2540558
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 21:31:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XyL_56I2RlTW for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 21:31:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8B62400B8
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 21:31:58 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1651872716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5YNXQOpOKXFVRz3iHvR1oAhEwQUbYYWJsKq1pUtVwd8=;
 b=A49620i7PRera+mhe1BweZ6Vv1Q3trFfvTBAN/4Kjrnu3jQc1o9ibi6TM3bHEk90av0atW
 t9hqMpAcGdW4SbUyZKmSOSd+YlbwGKNdD6WfYWTyEzICdgkDD0w9sM4vLp4oY9i0+I5D/s
 dNOmLMo8e7yKP2U1yZBOHkPKvDaLhKvj9DxFUsSN8bABxScYUK6yIdXlqeFsbRDt+wk7c4
 kvHyI7hjY2t5z2YVBVNHsqYSKqGW+DG2/TPqmSbklG7oUZCmxm5l3r7wnnk6rIfkS8A7Va
 sguCM4GL4nhWAwPbS2G9vdH00Fudh92BSslQrn7pJwyRBDGSW9Q3cY47KyfFoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1651872716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5YNXQOpOKXFVRz3iHvR1oAhEwQUbYYWJsKq1pUtVwd8=;
 b=3yzJVIl7aCbWJSTq+FwrDzYos2+d1FJ1UOnv4pyL8gSCEpD/WyUdjoYCOlOsOeDopNjtU5
 7RCkeX440NM7qOAg==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v6 13/29] iommu/amd: Compose MSI messages for NMI irqs
 in non-IR format
In-Reply-To: <20220506000008.30892-14-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-14-ricardo.neri-calderon@linux.intel.com>
Date: Fri, 06 May 2022 23:31:56 +0200
Message-ID: <87r156fiur.ffs@tglx>
MIME-Version: 1.0
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 Ricardo Neri <ricardo.neri@intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> +	 *
> +	 * Also, NMIs do not have an associated vector. No need for cleanup.

They have a vector and what the heck is this cleanup comment for here?
There is nothing cleanup alike anywhere near.

Adding confusing comments is worse than adding no comments at all.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
