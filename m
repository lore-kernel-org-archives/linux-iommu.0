Return-Path: <SRS0=ZipC=YH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBF1C4CECE
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 13:16:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A3D21835
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 13:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYSxzC7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A3D21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 25CDFD2E;
	Mon, 14 Oct 2019 13:16:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 84C9123CC
	for <iommu@lists.linux-foundation.org>;
	Sun, 13 Oct 2019 14:28:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com
	[209.85.166.50])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0DB7C6CE
	for <iommu@lists.linux-foundation.org>;
	Sun, 13 Oct 2019 14:28:39 +0000 (UTC)
Received: by mail-io1-f50.google.com with SMTP id b19so31809263iob.4
	for <iommu@lists.linux-foundation.org>;
	Sun, 13 Oct 2019 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=5aBuMFA748fTrf02FvJiD0JFK/wwa91gpvKKZDtOpDI=;
	b=gYSxzC7i4ZtIUcCtr+Q28cAaZoeV1PpQw3wZ5dYrdvV+nsjldceEMKhyKDp3wCr2b9
	WmmStUBELvQzxBLaiPXBYTL+g8Y7FBaVxdqgAdWkxKfYeO/oyqrVCLnDkdgtBUcjsClf
	7f7aWEIdb92UxMpilaUCeOpHzxfdxNeu9WAimjoaobUjQpDD1vVr9rwkDjtD9uYnF0pN
	EcXX7WQAhoTz6nRdYV5E1XEU8D1SXkykRVTE/eWCslgXkgbnmWsFrCuozrIW5ldMQCGL
	Gtzm0tXjrniwlCXeQyctuMZ6MHqa7WvrbKmxhvqN9C8O1C/V58jYZ3mCwdsqQuN/kLfu
	AxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
	bh=5aBuMFA748fTrf02FvJiD0JFK/wwa91gpvKKZDtOpDI=;
	b=KQZTojdlEveI5rp7da34kMsI4ur+GcK8e/FdCsvcqsmK9MQQVpP4K+evXVG8xIDT9o
	+dpsZ3F1jXOmAGh4hGuxVzU32QIcV16yMmGWESfhlZ4jjUgzB8gKkieM+jFigRtwSKv2
	OAPjhetG7FTBbquL00+ySpzTK1gEEnNczj2G05PlDd/BUYTHoPOLiapwzbdV8rdRZE3S
	x5XV+sjkN1RJ9o8P/jItgUn6J27GwHZOxI97MHWPEQ6P7qrBfSjsIXFzPk2NaHjZmuAj
	dKrEaLzZlGQDEGSBv3qXlpoFJHh4+BvvgLfu8xbNAJsIS26msPZn0ZEfMr91tlvnAoC0
	cRRg==
X-Gm-Message-State: APjAAAWv3BD8VB2KalAVQQ+fl4fdIMxoAdMBL/zofthpkCIcXxtvQiel
	74hoXn084sd+IUkGb1Hacz+a5tyOuGTGqYDXVxg=
X-Google-Smtp-Source: APXvYqz+Txov90/ZpaqL3xj1pCKeDwBh2fvcwZqo3GDujYgnp9SDtChPH4NEuGKvd9ykzIVVuOLbRnRKAIdtGme6SMU=
X-Received: by 2002:a5e:8711:: with SMTP id y17mr22582559ioj.227.1570976919262;
	Sun, 13 Oct 2019 07:28:39 -0700 (PDT)
MIME-Version: 1.0
From: Daniele Alessandrelli <daniele.alessandrelli@gmail.com>
Date: Sun, 13 Oct 2019 15:28:28 +0100
Message-ID: <CAA2QUqLv+eLXuA_TdJ7zM4oBnGoFVOjRjAimuct2y=0MDuaZVQ@mail.gmail.com>
Subject: [BUG] dma-ranges, reserved memory regions, dma_alloc_coherent:
	possible bug?
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
X-Mailman-Approved-At: Mon, 14 Oct 2019 13:08:31 +0000
Cc: iommu@lists.linux-foundation.org, Vladimir Murzin <vladimir.murzin@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
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

Hi,

It looks like dma_alloc_coherent() is setting the dma_handle output
parameter to the memory physical address and not the device bus
address when the device is using reserved memory regions for DMA
allocation. This is despite using 'dma_ranges' in the device tree to
describe the DMA memory mapping. Is this expected behavior or a bug?

Here is a reduced version of the device tree I'm using:
\ {
        reserved-memory {
                #address-cells = <2>;
                #size-cells = <2>;
                ranges;
                mydev_rsvd: rsvd_mem@494800000 {
                        compatible = "shared-dma-pool";
                        reg = <0x4 0x94800000 0x0 0x200000>;
                        no-map;
                };
        };
        soc {
                compatible = "simple-bus";
                #address-cells = <2>;
                #size-cells = <2>;
                ranges;
                dma_ranges;

                mybus {
                        ranges = <>;
                        dma-ranges = <>;
                        compatible = "simple-bus";
                        #address-cells = <2>;
                        #size-cells = <2>;
                        ranges =     <0x0 0x0  0x0 0x0  0x0 0x80000000>;
                        dma-ranges = <0x0 0x80000000  0x4 0x80000000
0x0 0x80000000>;

                        mydevice {
                                compatible = "my-compatible-string";
                                memory-region = <&mydev_rsvd>;
                        }
                }
        }
};

It looks like this issue was previously fixed by commit c41f9ea998f3
("drivers: dma-coherent: Account dma_pfn_offset when used with device
tree") which introduced a new function ('dma_get_device_base()') to
return the reserved memory address as seen by the device. However,
such a function, even if still there, is not used anymore in latest
code (as of v5.4-rc2). Was that done for a specific reason? Or is it
just a mistake?

Regards,
Daniele
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
