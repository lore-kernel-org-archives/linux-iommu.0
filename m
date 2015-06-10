From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: re: iommu: Introduce iommu_request_dm_for_dev()
Date: Wed, 10 Jun 2015 14:02:44 +0300
Message-ID: <20150610110244.GA21994@mwanda>
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

The patch eeae3fba3afe: "iommu: Introduce iommu_request_dm_for_dev()" 
from May 28, 2015, leads to the following Smatch complaint:

drivers/iommu/iommu.c:1581 iommu_request_dm_for_dev()
	 error: we previously assumed 'group->default_domain' could be null (see line 1558)

drivers/iommu/iommu.c
  1557		/* Check if the default domain is already direct mapped */
  1558		ret = 0;
  1559		if (group->default_domain &&
                    ^^^^^^^^^^^^^^^^^^^^^
Check for NULL.

  1560		    group->default_domain->type == IOMMU_DOMAIN_IDENTITY)
  1561			goto out;
  1562	
  1563		/* Don't change mappings of existing devices */
  1564		ret = -EBUSY;
  1565		if (iommu_group_device_count(group) != 1)
  1566			goto out;
  1567	
  1568		/* Allocate a direct mapped domain */
  1569		ret = -ENOMEM;
  1570		dm_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_IDENTITY);
  1571		if (!dm_domain)
  1572			goto out;
  1573	
  1574		/* Attach the device to the domain */
  1575		ret = __iommu_attach_group(dm_domain, group);
  1576		if (ret) {
  1577			iommu_domain_free(dm_domain);
  1578			goto out;
  1579		}
  1580	
  1581		/* Make the direct mapped domain the default for this group */
  1582		iommu_domain_free(group->default_domain);
                                  ^^^^^^^^^^^^^^^^^^^^^
Dereferenced inside function.

  1583		group->default_domain = dm_domain;

regards,
dan carpenter
