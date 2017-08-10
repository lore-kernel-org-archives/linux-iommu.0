From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [bug report] iommu/ipmmu-vmsa: Replace local utlb code with fwspec ids
Date: Thu, 10 Aug 2017 15:12:34 +0300
Message-ID: <20170810121234.oplcckhlbtdff5so@mwanda>
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
To: damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello Magnus Damm,

This is a semi-automatic email about new static checker warnings.

The patch 7b2d59611fef: "iommu/ipmmu-vmsa: Replace local utlb code 
with fwspec ids" from Jul 17, 2017, leads to the following Smatch 
complaint:

drivers/iommu/ipmmu-vmsa.c:555 ipmmu_attach_device()
	 warn: variable dereferenced before check 'priv' (see line 549)

drivers/iommu/ipmmu-vmsa.c
   548		struct iommu_fwspec *fwspec = dev->iommu_fwspec;
   549		struct ipmmu_vmsa_device *mmu = priv->mmu;
                                                ^^^^^^^^^
Old dereference.

   550		struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
   551		unsigned long flags;
   552		unsigned int i;
   553		int ret = 0;
   554	
   555		if (!priv || !priv->mmu) {
                     ^^^^
Patch adds new check.  Should this be checking fwspec?

   556			dev_err(dev, "Cannot attach to IPMMU\n");
   557			return -ENXIO;

regards,
dan carpenter
