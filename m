From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [bug report] iommu/amd: Use is_attach_deferred call-back
Date: Thu, 24 Aug 2017 14:04:06 +0300
Message-ID: <20170824110406.vm4yqalngig4seep@mwanda>
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
To: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello Baoquan He,

This is a semi-automatic email about new static checker warnings.

The patch df3f7a6e8e85: "iommu/amd: Use is_attach_deferred call-back" 
from Aug 9, 2017, leads to the following Smatch complaint:

drivers/iommu/amd_iommu.c:2265 get_domain()
	 error: we previously assumed 'domain' could be null (see line 2259)

drivers/iommu/amd_iommu.c
  2258		domain = get_dev_data(dev)->domain;
  2259		if (domain == NULL && get_dev_data(dev)->defer_attach) {
                    ^^^^^^^^^^^^^^
The patch adds a new check for NULL.

  2260			get_dev_data(dev)->defer_attach = false;
  2261			io_domain = iommu_get_domain_for_dev(dev);
  2262			domain = to_pdomain(io_domain);
  2263			attach_device(dev, domain);
  2264		}
  2265		if (!dma_ops_domain(domain))
                                    ^^^^^^
Existing unchecked dereference inside the function.

  2266			return ERR_PTR(-EBUSY);
  2267	

regards,
dan carpenter
