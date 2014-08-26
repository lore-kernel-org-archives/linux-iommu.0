From: Andy Burns <iommu+lists-6TVDe6PzSGq9FHfhHBbuYA@public.gmane.org>
Subject: Re: [RFC PATCH v2 2/2] iommu/intel: Make use of PCIe requester ID
	interface
Date: Tue, 26 Aug 2014 08:49:27 +0100
Message-ID: <53FC3C07.8050906@adslpipe.co.uk>
References: <53FC33AF.5040407@adslpipe.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <53FC33AF.5040407-6TVDe6PzSGq9FHfhHBbuYA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Andy Burns wrote:

> I'm running into an IOMMU crash on CentOS7, it seems this patch series
> aims to fix the same type of issue

Sorry, I thought I was dragging up a 1 month old thread, not a 13 month 
old thread!

Am I correct that this became part of the 13 patch set of 1st May 2014, 
where I saw reference to

"should also enable motherboards with an onboard ASmedia
ASM1083/1085 PCIe-to-PCI bridge to work with VT-d enabled"

Are any parts of this in mainline yet?
