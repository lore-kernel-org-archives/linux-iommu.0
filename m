Return-Path: <SRS0=5HPr=TQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061BDC04AB4
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 08:47:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77AA205C9
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 08:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77AA205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AB3CCC37;
	Thu, 16 May 2019 08:47:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 480C9BA9
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 08:47:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CEBBE878
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 08:47:47 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 05982AEDB;
	Thu, 16 May 2019 08:47:46 +0000 (UTC)
Message-ID: <1557995692.14649.2.camel@suse.com>
Subject: Re: Linux crash when using FTDI FT232R USB to serial converter on
	AMD boards.
From: Oliver Neukum <oneukum@suse.com>
To: "StarostaCZ@gmail.com" <starostacz@gmail.com>, Joerg Roedel
	<joro@8bytes.org>, Johan Hovold <johan@kernel.org>
Date: Thu, 16 May 2019 10:34:52 +0200
In-Reply-To: <b4c3eba7-758d-7951-afd0-d90a261346e8@gmail.com>
References: <04503197-a0a9-8b35-6c65-c10f296aab57@gmail.com>
	<20190429094847.GI26546@localhost> <20190503153716.GE11605@8bytes.org>
	<8748125e-f360-ff0e-ea15-699bce9e7747@gmail.com>
	<4e7f0267-eba8-81c3-4036-25924ea9df98@gmail.com>
	<1557911856.2950.10.camel@suse.com>
	<3e7ec2f2-ac47-a031-96ba-fa2b9f21ed2e@gmail.com>
	<1557913582.2950.15.camel@suse.com>
	<c57ccafd-7ad4-63e4-54c1-e1fb136ebeed@gmail.com>
	<1557928483.2950.18.camel@suse.com>
	<4a48a017-fbcb-619f-f2d5-4d627a673021@gmail.com>
	<1557993530.14649.0.camel@suse.com>
	<b4c3eba7-758d-7951-afd0-d90a261346e8@gmail.com>
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
	Mathias Nyman <mathias.nyman@intel.com>
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

On Do, 2019-05-16 at 10:20 +0200,  StarostaCZ@gmail.com  wrote:
> Dne 16.5.2019 v 9:58 Oliver Neukum napsal(a):
> > > > 2.Send a new report to the corresponding mailing list
> > > 
> > > Which mailing list is correct?
> > 
> > In that case linux-usb@vger.kernel.org
> > 
> > 	HTH
> > 		Oliver
> > 
> 
> Is there some rules how to send bug report? Or I can send report with 
> "my amateur description"?

Mention

1. kernel version
2. whether this is known to be a regression
3. include the log with iommu disabled and mention that you disabled
the IOMMU
4. Include the output of lsusb

	HTH
		Oliver

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
