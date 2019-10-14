Return-Path: <SRS0=ZipC=YH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2688DC4CECE
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 14:21:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B072067B
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 14:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B072067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5970A1512;
	Mon, 14 Oct 2019 14:21:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A3B6D145D
	for <iommu@lists.linux-foundation.org>;
	Mon, 14 Oct 2019 14:10:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 339F38A9
	for <iommu@lists.linux-foundation.org>;
	Mon, 14 Oct 2019 14:10:21 +0000 (UTC)
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtpsa
	(TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1iK139-0001Ft-NS; Mon, 14 Oct 2019 16:10:15 +0200
Date: Mon, 14 Oct 2019 16:10:15 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: Re: Advice on oops - memory trap on non-memory access instruction
	(invalid CR2?)
In-Reply-To: <66eeae28-bfd3-c7a0-011c-801981b74243@canonical.com>
Message-ID: <alpine.DEB.2.21.1910141602270.2531@nanos.tec.linutronix.de>
References: <66eeae28-bfd3-c7a0-011c-801981b74243@canonical.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: halves@canonical.com, mfo@canonical.com, kvm@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org,
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org, ioanna-maria.alifieraki@canonical.com,
	jay.vosburgh@canonical.com, gavin.guo@canonical.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, 14 Oct 2019, Guilherme G. Piccoli wrote:
> Modules linked in: <...>
> CPU: 40 PID: 78274 Comm: qemu-system-x86 Tainted: P W  OE

Tainted: P     - Proprietary module loaded ...

Try again without that module

Tainted: W     - Warning issued before

Are you sure that that warning is harmless and unrelated?

> 4.4.0-45-generic #66~14.04.1-Ubuntu

Does the same problem happen with a not so dead kernel? CR2 handling got
quite some updates/fixes since then.

Thanks,

	tglx


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
