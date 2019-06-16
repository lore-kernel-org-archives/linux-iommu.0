Return-Path: <SRS0=mBvT=UP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726EBC31E54
	for <iommu@archiver.kernel.org>; Sun, 16 Jun 2019 18:42:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA292087F
	for <iommu@archiver.kernel.org>; Sun, 16 Jun 2019 18:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA292087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 15B12A70;
	Sun, 16 Jun 2019 18:42:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DE5B9265
	for <iommu@lists.linux-foundation.org>;
	Sun, 16 Jun 2019 18:42:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0D345E5
	for <iommu@lists.linux-foundation.org>;
	Sun, 16 Jun 2019 18:42:41 +0000 (UTC)
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
	by Galois.linutronix.de with esmtpsa
	(TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hca6i-0002sP-VE; Sun, 16 Jun 2019 20:42:25 +0200
Date: Sun, 16 Jun 2019 20:42:23 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [RFC PATCH v4 20/21] iommu/vt-d: hpet: Reserve an interrupt
	remampping table entry for watchdog
In-Reply-To: <1558660583-28561-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1906162039260.1760@nanos.tec.linutronix.de>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1558660583-28561-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
	SHORTCIRCUIT=-0.0001
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Stephane Eranian <eranian@google.com>, Ingo Molnar <mingo@kernel.org>,
	Wincy Van <fanwenyi0529@gmail.com>,
	Ashok Raj <ashok.raj@intel.com>, x86@kernel.org,
	Andi Kleen <andi.kleen@intel.com>, Borislav Petkov <bp@suse.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Jacob Pan <jacob.jun.pan@intel.com>,
	Philippe Ombredanne <pombredanne@nexb.com>
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

On Thu, 23 May 2019, Ricardo Neri wrote:

> When interrupt remapping is enabled, MSI interrupt messages must follow a
> special format that the IOMMU can understand. Hence, when the HPET hard
> lockup detector is used with interrupt remapping, it must also follow this
> special format.
> 
> The IOMMU, given the information about a particular interrupt, already
> knows how to populate the MSI message with this special format and the
> corresponding entry in the interrupt remapping table. Given that this is a
> special interrupt case, we want to avoid the interrupt subsystem. Add two
> functions to create an entry for the HPET hard lockup detector. Perform
> this process in two steps as described below.
> 
> When initializing the lockup detector, the function
> hld_hpet_intremap_alloc_irq() permanently allocates a new entry in the
> interrupt remapping table and populates it with the information the
> IOMMU driver needs. In order to populate the table, the IOMMU needs to
> know the HPET block ID as described in the ACPI table. Hence, add such
> ID to the data of the hardlockup detector.
> 
> When the hardlockup detector is enabled, the function
> hld_hpet_intremapactivate_irq() activates the recently created entry
> in the interrupt remapping table via the modify_irte() functions. While
> doing this, it specifies which CPU the interrupt must target via its APIC
> ID. This function can be called every time the destination iD of the
> interrupt needs to be updated; there is no need to allocate or remove
> entries in the interrupt remapping table.

And except for a few details all of this functionality exists today. There
is no need to hack HPET NMI specific knowledge into the irq remapping
driver. And of course to unbreak AMD you'd have to copy the same hackery
into the AMD interrupt remapping code.

More lines of duplicated duct tape code are better to maintain, right?

Sigh.

	tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
