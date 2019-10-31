Return-Path: <SRS0=DWjf=YY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1EBC47E49
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 15:42:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EE621734
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 15:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaAJ8XcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EE621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BB1ECC87;
	Thu, 31 Oct 2019 15:42:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 85EC1C6C
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 15:42:52 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 408828B0
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 15:42:52 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id DECD82086D;
	Thu, 31 Oct 2019 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572536572;
	bh=GRreUt5vILq8iwJLnTWSsnpWtfLL+f+wCy2zYdNxf6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qaAJ8XcWGfT4LUOvU811aRsvOWAxezJATr7Uk9nzN23oXUvKxtHZVcY0AqzVTOyjZ
	Epk2/3n2IWDhuOaWcOoDQDWApaqgYgldCxMrpckQEgKjPXnL2Tv96+pJVdwc1WPwcm
	ftKHIyiFmV9Fi/cSBRpiXvhFrSLJm+8Fm2Mkj3Fg=
Date: Thu, 31 Oct 2019 15:42:47 +0000
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 5/7] iommu/arm-smmu-v3: Allow building as a module
Message-ID: <20191031154247.GB28061@willie-the-truck>
References: <20191030145112.19738-1-will@kernel.org>
	<20191030145112.19738-6-will@kernel.org>
	<20191030193148.GA8432@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191030193148.GA8432@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
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

Hi Joerg,

On Wed, Oct 30, 2019 at 08:31:48PM +0100, Joerg Roedel wrote:
> On Wed, Oct 30, 2019 at 02:51:10PM +0000, Will Deacon wrote:
> > By removing the redundant call to 'pci_request_acs()' we can allow the
> > ARM SMMUv3 driver to be built as a module.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  drivers/iommu/Kconfig       | 2 +-
> >  drivers/iommu/arm-smmu-v3.c | 1 -
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index e3842eabcfdd..7583d47fc4d5 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -388,7 +388,7 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
> >  	  config.
> >  
> >  config ARM_SMMU_V3
> > -	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
> > +	tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
> >  	depends on ARM64
> >  	select IOMMU_API
> >  	select IOMMU_IO_PGTABLE_LPAEa
> 
> Sorry for the stupid question, but what prevents the iommu module from
> being unloaded when there are active users? There are no symbol
> dependencies to endpoint device drivers, because the interface is only
> exposed through the iommu-api, right? Is some sort of manual module
> reference counting needed?

Generally, I think unloading the IOMMU driver module while there are
active users is a pretty bad idea, much like unbinding the driver via
/sys in the same situation would also be fairly daft. However, I *think*
the code in __device_release_driver() tries to deal with this by
iterating over the active consumers and ->remove()ing them first.

I'm without hardware access at the moment, so I haven't been able to
test this myself. We could nobble the module_exit() hook, but there's
still the "force unload" option depending on the .config.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
