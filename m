From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: iommu/arm-smmu-v2 ASID/VMID calculation
Date: Wed, 27 Jan 2016 19:08:50 +0000
Message-ID: <20160127190849.GF25545@arm.com>
References: <198F501C-8D30-4EB5-BC40-4F40BB75D40B@caviumnetworks.com>
	<20160125170312.GJ22927@arm.com>
	<E978AB4F-5CB0-42D8-8152-04C77DB664A1@caviumnetworks.com>
	<6F24A28A-6302-4C48-A933-B47A9735808C@caviumnetworks.com>
	<20160126115435.GB21553@arm.com>
	<E0484253-BE37-476A-9F4A-ABE6B74EC174@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E0484253-BE37-476A-9F4A-ABE6B74EC174-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 27, 2016 at 07:06:48PM +0000, Chalamarla, Tirumalesh wrote:
> On 1/26/16, 3:54 AM, "Will Deacon" <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> >The problem is that you have shared state between multiple SMMU instances,
> >which I don't think is correct. I'm fine with a workaround, but I don't
> >want this logic to be used on other implementations where it is not
> >needed.
> 
> Ok, I will treat it as Errata and provide a patch for workaround this. 

Thank you.

Will
