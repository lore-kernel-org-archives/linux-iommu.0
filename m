From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: re: iommu/amd: Put IOMMUv2 devices in a direct mapped domain
Date: Wed, 10 Jun 2015 18:36:18 +0300
Message-ID: <20150610153618.GA10549@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: jroedel-l3A5Bk7waGM@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello Joerg Roedel,

This is a semi-automatic email about new static checker warnings.

The patch 0a3da4517107: "iommu/amd: Put IOMMUv2 devices in a direct 
mapped domain" from May 28, 2015, leads to the following Smatch 
complaint:

drivers/iommu/amd_iommu.c:2285 amd_iommu_add_device()
	 error: we previously assumed 'dev_data' could be null (see line 2279)

drivers/iommu/amd_iommu.c
  2278		dev_data = get_dev_data(dev);
  2279		if (dev_data && dev_data->iommu_v2)
                    ^^^^^^^^
Check.

  2280			iommu_request_dm_for_dev(dev);
  2281	
  2282		/* Domains are initialized for this device - have a look what we ended up with */
  2283		domain = iommu_get_domain_for_dev(dev);
  2284		if (domain->type == IOMMU_DOMAIN_IDENTITY) {
  2285			dev_data->passthrough = true;
                        ^^^^^^^^^^
Unchecked dereference.

  2286			dev->archdata.dma_ops = &nommu_dma_ops;
  2287		} else {

regards,
dan carpenter
