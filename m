Return-Path: <SRS0=QAQK=UU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0906C43613
	for <iommu@archiver.kernel.org>; Fri, 21 Jun 2019 18:49:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D9520657
	for <iommu@archiver.kernel.org>; Fri, 21 Jun 2019 18:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sn4kS+bU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D9520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7E9551312;
	Fri, 21 Jun 2019 18:49:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A055910D8
	for <iommu@lists.linux-foundation.org>;
	Fri, 21 Jun 2019 17:43:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3EE9D7DB
	for <iommu@lists.linux-foundation.org>;
	Fri, 21 Jun 2019 17:43:50 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id z19so760761pgl.12
	for <iommu@lists.linux-foundation.org>;
	Fri, 21 Jun 2019 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=2pbfkZnNtwxho5vGdOe6FtdRxb/ZcWHyWe7FQ5e3h4Q=;
	b=sn4kS+bU7/Kbv9eioXyl3cDTTyeR09xPPdgQ0CullBFMQjKpQLyGZ3aGzfacXJ+ovQ
	xp7a1HBITcLhnqW6aXd0q2jIfiW1eP80lkuDq7g88/yCJnNC5jTa+yPEQunl55dM33Bl
	eg6B9WC+dyU62YT53Tbhh5vPuJSeUUslQ2cWRRwWVOYnUkxj9KBdnjpXWREeEHtwKTYC
	Z3YNX9pmKdDSpuz+OExOlxRH74j6f72cZPJbkUXt9demOlEfHPuSkeCeFHN4K7pvxO0n
	bXe60lYOuTriQ152ALRBk5C1qncD3uxJBowHBT4qn07u+WnvoMKGnzdHT+3m6Bh+AGng
	/Vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=2pbfkZnNtwxho5vGdOe6FtdRxb/ZcWHyWe7FQ5e3h4Q=;
	b=ZCeUFEVKIrcqNaNGWNfuZJNLXj3R63LtP+9+kr6NbYAItENZXG/w9UJn3HkuRB0U8j
	B+WTOsnAWDuuY8UeNF9YUD/qgK+XuU9WQlESfDjr9DwTnxXENs5/K7tvo9jeK6z9ycwa
	dYynNpTnm4TQNro1RBztODAYhl/xlnwWl+r211dyiEEvxTt9xMmP+NRyP7XfVRqiiqCG
	Yjtyf6a9y2ML71Ud2MV7wUKLNys/o3bfmm7xmZyLEby2kl8VLb3TLG3rmyF9xl1WVOgq
	yHN7in0ixiUmsuYI8q5DzaaPiHUJuc3Qk//jvO5bm6pNUt1kPMNetKH7JVwnK1JXJFJQ
	6fgw==
X-Gm-Message-State: APjAAAWyon6JXPsMQCfhk+i/+7UMPrAoWbpxZtsS61mGqyJswRIp+7L2
	p16lvxYlIaqukXvSKRYtcNg=
X-Google-Smtp-Source: APXvYqysaLeyOSucPthfuXN5XsRYxePAZMQGO/ppCPMjOGa0B2SGss3rnVn9ijOUpcobbtg687DU3g==
X-Received: by 2002:a63:8341:: with SMTP id h62mr8739794pge.206.1561139029712; 
	Fri, 21 Jun 2019 10:43:49 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
	by smtp.gmail.com with ESMTPSA id
	r15sm6233971pfc.162.2019.06.21.10.43.46
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 21 Jun 2019 10:43:49 -0700 (PDT)
Date: Sat, 22 Jun 2019 02:43:43 +0900
From: Suwan Kim <suwan.kim027@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: How to resolve an issue in swiotlb environment?
Message-ID: <20190621174342.GA28335@localhost.localdomain>
References: <7a6450cd-7b68-778d-0124-3c21d4616069@kernel.org>
	<Pine.LNX.4.44L0.1906191649350.1596-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906191649350.1596-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Mailman-Approved-At: Fri, 21 Jun 2019 18:49:28 +0000
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	shuah <shuah@kernel.org>, Christoph Hellwig <hch@lst.de>
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

On Wed, Jun 19, 2019 at 05:05:49PM -0400, Alan Stern wrote:
> On Wed, 19 Jun 2019, shuah wrote:
> 
> > I missed a lot of the thread info. and went looking for it and found the
> > following summary of the problem:
> > 
> > ==================
> > The issue which prompted the commit this thread is about arose in a
> > situation where the block layer set up a scatterlist containing buffer
> > sizes something like:
> > 
> > 	4096 4096 1536 1024
> > 
> > and the maximum packet size was 1024.  The situation was a little
> > unusual, because it involved vhci-hcd (a virtual HCD).  This doesn't
> > matter much in normal practice because:
> > 
> > 	Block devices normally have a block size of 512 bytes or more.
> > 	Smaller values are very uncommon.  So scatterlist element sizes
> > 	are always divisible by 512.
> > 
> > 	xHCI is the only USB host controller type with a maximum packet
> > 	size larger than 512, and xHCI hardware can do full
> > 	scatter-gather so it doesn't care what the buffer sizes are.
> > 
> > So another approach would be to fix vhci-hcd and then trust that the
> > problem won't arise again, for the reasons above.  We would be okay so
> > long as nobody tried to use a USB-SCSI device with a block size of 256
> > bytes or less.
> > ===================
> > 
> > Out of the summary, the following gives me pause:
> > 
> > "xHCI hardware can do full scatter-gather so it doesn't care what the
> > buffer sizes are."
> > 
> > vhci-hcd won't be able to count on hardware being able to do full
> > scatter-gather. It has to deal with a variety of hardware with
> > varying speeds.
> 
> Sure.  But you can test whether the server's HCD is able to handle 
> scatter-gather transfers, and if it is then you can say that the 
> client-side vhci-hcd is able to handle them as well.  Then all you 
> would have to do is preserve the scatterlist information describing the 
> transfer when you go between the client and the server.
> 
> The point is to make sure that the client-side vhci-hcd doesn't claim
> to be _less_ capable than the server-side actual HCD.  That's what
> leads to the problem described above.
> 
> > "We would be okay so long as nobody tried to use a USB-SCSI device with
> > a block size of 256 bytes or less."
> > 
> > At least a USB Storage device, I test with says 512 block size. Can we
> > count on not seeing a device with block size <= 256 bytes?
> 
> Yes, we can.  In fact, the SCSI core doesn't handle devices with block 
> size < 512.
> 
> > In any case, I am looking into adding SG support vhci-hci at the moment.
> > 
> > Looks like the following is the repo, I should be working with?
> > 
> > git://git.infradead.org/users/hch/misc.git
> 
> It doesn't matter.  Your work should end up being independent of 
> Christoph's, so you can base it on any repo.

I implemented SG support of vhci. I will send it as a patch.
Please look at it and let me know if you have a feedback.

Regards

Suwan Kim
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
