From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Fwd: [RFC] DMA mapping error check analysis
Date: Thu, 13 Sep 2012 10:56:37 -0400
Message-ID: <5051F425.2090204@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

For those on the iommu list that are not on
the devel-drivers or lkml list....

Since failures/bugs in drivers using dma mapping API
result in IOMMU detected failures (faults) or IOMMU resource leakage...



-------- Original Message --------
Subject: [RFC] DMA mapping error check analysis
Date: Fri, 07 Sep 2012 09:53:20 -0600
From: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
Reply-To: shuah.khan-VXdhtT5mjnY@public.gmane.org
Organization: ISS-Linux
To: fujita.tomonori-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org,        paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org,        joerg.roedel-5C7GfCeVMHo@public.gmane.org, paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org, kubakici-5tc4TXWwyLM@public.gmane.org,        stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,        Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
CC: devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,        shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

I analyzed all calls to dma_map_single() and dma_map_page() in the
kernel, to see if callers check for mapping errors, before using the
returned address.

The goal of this analysis is to find drivers that currently do not
check dma mapping errors, and fix them.

I documented the results of this analysis:

http://linuxdriverproject.org/mediawiki/index.php/DMA_Mapping_Error_Analysis

Please review and give me feedback on the analysis and the proposed
next steps.

Thanks,
-- Shuah

_______________________________________________
devel mailing list
devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/devel
