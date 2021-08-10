Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626E5C4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 16:54:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0807D60F94
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 16:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0807D60F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D02836079B;
	Tue, 10 Aug 2021 16:54:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XSifAm5QTdwl; Tue, 10 Aug 2021 16:54:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6D76560768;
	Tue, 10 Aug 2021 16:54:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71F1CC0027;
	Tue, 10 Aug 2021 16:54:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA76CC000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 16:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA5D7607E4
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 16:23:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1BwZP6JK5G0X for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 16:23:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A9D2606CB
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 16:23:23 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14D0260F02;
 Tue, 10 Aug 2021 16:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628612602;
 bh=nczmLTVxEQtoxBkAO9L8Lie/2UE68qMsN3DD27DRIPo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QMNkRNQGRWg7IiWDhIzmGV4aTK74KV5IWwwyH7w5eZzNdbLPDqb4mv8HGpr7JtM8T
 JE+V39EIN/+CqKz7AS7zDJHTBwwZ7eOcleu4b99XNw9KaBwoXG2rPutRnI7eZzb+3l
 oENWbv4zay3ZWfPoeeiWVa5PDHjf587E7MwHuwew0LuMSFPFZteSZF/sZonTLf0SON
 6e8GQUdcWDYTGq3/gZ+ccleZlmVETzBiOyEhOJLBlAdhNeZQbsc6dCDZko/fa4vjJ4
 NoqGXgLRZ6d2H/CTAFl+WTfSkfzp+DGif+X1oETip6u5UZfc+YqZM/ymQfK+nF9BSL
 jmmo8L3Wewyuw==
Date: Tue, 10 Aug 2021 19:23:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Subject: Re: [PATCH v3 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
Message-ID: <20210810162320.6rfpvdvzgxi35ylx@kernel.org>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
X-Mailman-Approved-At: Tue, 10 Aug 2021 16:54:15 +0000
Cc: linux-doc@vger.kernel.org, dpsmith@apertussolutions.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, luto@amacapital.net,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, kanth.ghatraju@oracle.com, linux-integrity@vger.kernel.org,
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

On Mon, Aug 09, 2021 at 12:38:42PM -0400, Ross Philipson wrote:
> The focus of Trechboot project (https://github.com/TrenchBoot) is to
> enhance the boot security and integrity. This requires the linux kernel
                                                             ~~~~~
                                                             Linux

How does it enhance it? The following sentence explains the requirements
for the Linux kernel, i.e. it's a question without answer. And if there
is no answer, there is no need to merge this.

/Jarkko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
