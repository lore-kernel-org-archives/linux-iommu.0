Return-Path: <SRS0=3Hvu=YB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC8AC4360C
	for <iommu@archiver.kernel.org>; Tue,  8 Oct 2019 21:46:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F96C20679
	for <iommu@archiver.kernel.org>; Tue,  8 Oct 2019 21:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaF0YI7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F96C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A492CAF0;
	Tue,  8 Oct 2019 21:46:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6FDBD49F
	for <iommu@lists.linux-foundation.org>;
	Tue,  8 Oct 2019 21:46:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
	[205.139.110.61])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id D6BFC14D
	for <iommu@lists.linux-foundation.org>;
	Tue,  8 Oct 2019 21:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1570571176;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=L+eZJJqrlbPqVzOZaO5qNFGym7u5qYSToEyvJ0eC7yw=;
	b=PaF0YI7u9XNrm+wKH2nycOeefgWmyLKH0PE1eJtPHquxi0MriZdsALVql00bXfx81hBFNA
	t74f+RPjPPAXB2FyClpF2+NOt/LvH+2C4bEtwV3PxaLcFntw/7/P8ImKeYLHQtBAlY7r3Q
	Ko49UQeukWG8+Fw6ZTRPwQzObT5/xFQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
	[209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-314-JMJJDchSPdmwZU9l0_2ljw-1; Tue, 08 Oct 2019 17:46:12 -0400
Received: by mail-io1-f70.google.com with SMTP id i2so582960ioo.10
	for <iommu@lists.linux-foundation.org>;
	Tue, 08 Oct 2019 14:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=R2PLCpCGC+X0FsCVNcoIrm/LGH7IA7bRES0qF3Fhu7k=;
	b=PoUgMJJaKrrvfY53VhdfQ5hYhypUP9WHouvSUY9dNeflmyNBofEFykdL/WH7Gn87UL
	mGwM0dCDH1Op+UcUWwGhsnv3DvU+cY40do1O/IgcFpU9D3A2sdHWyBmDhp2Yh4UTFFkO
	voNYVnkuBW0rpmOamHGLHJKD4j3ACyAgcvwRYNdAIpN80rzMpDbSvNifuw4KqYxnZH78
	vb2Bq8oSlx1tayK/xOyqzpbLimnpqLqGph6OTB3QpAeojff1kY/aKovjl0gWiP3aTiJ+
	U/Z0tOHd23Fl7egq2Wvta7yIh50R7CBnABcCtHys0TsenmX+fmayif4a7PgSpofycRsK
	1jsA==
X-Gm-Message-State: APjAAAV0do7Qj2yPpKg2mL8zMHK9pBUkddrdvaMf4dY8Xjq8cLnm2xRH
	UnYOFiFFOgLBY4bDW3pGR6xlONFGLpoHnwecZ+jWCxDcX5DurPH8+vMUMTt7lRPHmFzyENtO6kJ
	wt75d0G1VZeDjDcNPxFKQiffq4/XV/g==
X-Received: by 2002:a02:ac8e:: with SMTP id x14mr158790jan.11.1570571172226;
	Tue, 08 Oct 2019 14:46:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzRjkZNUFsMLmBAav/k9nqbRyvIxfGbTW0hIWLHgfdTSVeQ7myWycO2xJSmj0J/txoJdC1z/Q==
X-Received: by 2002:a02:ac8e:: with SMTP id x14mr158772jan.11.1570571171801;
	Tue, 08 Oct 2019 14:46:11 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
	by smtp.gmail.com with ESMTPSA id v69sm174162ila.6.2019.10.08.14.46.10
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 08 Oct 2019 14:46:11 -0700 (PDT)
Date: Tue, 8 Oct 2019 14:46:09 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 6/6] iommu/amd: Switch to use acpi_dev_hid_uid_match()
Message-ID: <20191008214609.wk2imvejk2h2pvil@cantor>
References: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
	<20191001142725.30857-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191001142725.30857-7-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: JMJJDchSPdmwZU9l0_2ljw-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue Oct 01 19, Andy Shevchenko wrote:
>Since we have a generic helper, drop custom implementation in the driver.
>
>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>---
> drivers/iommu/amd_iommu.c | 30 +++++-------------------------
> 1 file changed, 5 insertions(+), 25 deletions(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 2369b8af81f3..40f3cf44aa98 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -124,30 +124,6 @@ static struct lock_class_key reserved_rbtree_key;
>  *
>  ****************************************************************************/
>
>-static inline int match_hid_uid(struct device *dev,
>-				struct acpihid_map_entry *entry)
>-{
>-	struct acpi_device *adev = ACPI_COMPANION(dev);
>-	const char *hid, *uid;
>-
>-	if (!adev)
>-		return -ENODEV;
>-
>-	hid = acpi_device_hid(adev);
>-	uid = acpi_device_uid(adev);
>-
>-	if (!hid || !(*hid))
>-		return -ENODEV;
>-
>-	if (!uid || !(*uid))
>-		return strcmp(hid, entry->hid);
>-
>-	if (!(*entry->uid))
>-		return strcmp(hid, entry->hid);
>-
>-	return (strcmp(hid, entry->hid) || strcmp(uid, entry->uid));
>-}
>-
> static inline u16 get_pci_device_id(struct device *dev)
> {
> 	struct pci_dev *pdev = to_pci_dev(dev);
>@@ -158,10 +134,14 @@ static inline u16 get_pci_device_id(struct device *dev)
> static inline int get_acpihid_device_id(struct device *dev,
> 					struct acpihid_map_entry **entry)
> {
>+	struct acpi_device *adev = ACPI_COMPANION(dev);
> 	struct acpihid_map_entry *p;
>
>+	if (!adev)
>+		return -ENODEV;
>+
> 	list_for_each_entry(p, &acpihid_map, list) {
>-		if (!match_hid_uid(dev, p)) {
>+		if (acpi_dev_hid_uid_match(adev, p->hid, p->uid)) {
> 			if (entry)
> 				*entry = p;
> 			return p->devid;
>-- 
>2.23.0
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
