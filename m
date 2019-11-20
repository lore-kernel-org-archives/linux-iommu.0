Return-Path: <SRS0=wR7u=ZM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA666C432C3
	for <iommu@archiver.kernel.org>; Wed, 20 Nov 2019 19:51:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42D02071F
	for <iommu@archiver.kernel.org>; Wed, 20 Nov 2019 19:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbZyyAei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42D02071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 861901FD16;
	Wed, 20 Nov 2019 19:51:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W6VLoSmFQTqY; Wed, 20 Nov 2019 19:51:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D57BB20502;
	Wed, 20 Nov 2019 19:51:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF060C1DD8;
	Wed, 20 Nov 2019 19:51:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8675C18DA
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 19:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DD5BD1FF59
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 19:51:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OAPIPnh6R-iN for <iommu@lists.linux-foundation.org>;
 Wed, 20 Nov 2019 19:51:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 0ADB62FF74
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 19:49:50 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 983292068F;
 Wed, 20 Nov 2019 19:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574279389;
 bh=8OdhdfUvBh8yeItPx5lvDqJRDQbjk4jNjuLGV67HFng=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=GbZyyAeiPOGuUe8N9Fv82aD0Pxho+dCO/gqZASt0YMaHyTmsnepyhPWHi4F6E3Phf
 jUAFSXAIM8P2hprpRslh8ToPol8KmKVsY2+p5MB2UQYj0IOa6HKnCafT5bzsdT8K7l
 IksCj4JrRGuMlqVJRFKXNX+7eQdIEjpVSf5J3B1A=
Date: Wed, 20 Nov 2019 13:49:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] Ensure pci transactions coming from PLX NTB are handled
 when IOMMU is turned on
Message-ID: <20191120194948.GA117003@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c683ec65-40a9-6430-ae85-ce3934ed8af5@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Dmitry Safonov <dima@arista.com>, linux-pci@vger.kernel.org,
 Dmitry Safonov <0x7f454c46@gmail.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

On Wed, Nov 20, 2019 at 12:30:48PM -0700, Logan Gunthorpe wrote:
> On 2019-11-20 10:48 a.m., Dmitry Safonov wrote:
> > On 11/5/19 12:17 PM, James Sewart wrote:
> >>
> >>> On 24 Oct 2019, at 13:52, James Sewart <jamessewart@arista.com> wrote:
> >>>
> >>> The PLX PEX NTB forwards DMA transactions using Requester ID's that don't exist as
> >>> PCI devices. The devfn for a transaction is used as an index into a lookup table
> >>> storing the origin of a transaction on the other side of the bridge.
> >>>
> >>> This patch aliases all possible devfn's to the NTB device so that any transaction
> >>> coming in is governed by the mappings for the NTB.
> >>>
> >>> Signed-Off-By: James Sewart <jamessewart@arista.com>
> >>> ---
> >>> drivers/pci/quirks.c | 22 ++++++++++++++++++++++
> >>> 1 file changed, 22 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >>> index 320255e5e8f8..647f546e427f 100644
> >>> --- a/drivers/pci/quirks.c
> >>> +++ b/drivers/pci/quirks.c
> >>> @@ -5315,6 +5315,28 @@ SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
> >>> SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
> >>> SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
> >>>
> >>> +/*
> >>> + * PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints. These IDs
> >>> + * are used to forward responses to the originator on the other side of the
> >>> + * NTB. Alias all possible IDs to the NTB to permit access when the IOMMU is
> >>> + * turned on.
> >>> + */
> >>> +static void quirk_PLX_NTB_dma_alias(struct pci_dev *pdev)
> >>> +{
> >>> +	if (!pdev->dma_alias_mask)
> >>> +		pdev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
> >>> +					      sizeof(long), GFP_KERNEL);
> >>> +	if (!pdev->dma_alias_mask) {
> >>> +		dev_warn(&pdev->dev, "Unable to allocate DMA alias mask\n");
> >>> +		return;
> >>> +	}
> >>> +
> >>> +	// PLX NTB may use all 256 devfns
> >>> +	memset(pdev->dma_alias_mask, U8_MAX, (U8_MAX+1)/BITS_PER_BYTE);
> 
> I think it would be better to create a pci_add_dma_alias_range()
> function instead of directly accessing dma_alias_mask. We could then use
> that function to clean up quirk_switchtec_ntb_dma_alias() which is
> essentially doing the same thing.

Great idea!

Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
