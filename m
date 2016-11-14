From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
	callback
Date: Mon, 14 Nov 2016 17:20:37 +0100
Message-ID: <20161114162037.GC14829@8bytes.org>
References: <20161110154606.GH2078@8bytes.org>
	<04ed9694-707d-260b-70c6-f367d292ceca@redhat.com>
	<20161110161331.GJ2078@8bytes.org>
	<f4537e43-0237-e478-eacd-b107458628b8@redhat.com>
	<20161111114223.GP2078@8bytes.org>
	<79da09b8-ac1e-cebf-5393-7d67f002b3e3@redhat.com>
	<20161111162211.GU2078@8bytes.org>
	<634ac375-3507-6926-164f-e67f7c798c98@redhat.com>
	<20161114153149.GY2078@8bytes.org>
	<295feefe-014b-5669-7f5a-e04b09ba3454@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <295feefe-014b-5669-7f5a-e04b09ba3454-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 14, 2016 at 05:08:16PM +0100, Auger Eric wrote:
> There are potentially several MSI doorbell physical pages in the SOC
> that are accessed through the IOMMU (translated). Each of those must
> have a corresponding IOVA and IOVA/PA mapping programmed in the IOMMU.
> Else MSI will fault.
> 
> - step 1 was to define a usable IOVA range for MSI mapping. So now we
> decided the base address and size would be hardcoded for ARM. The
> get_dm_region can be used to retrieve that hardcoded region.
> - Step2 is to allocate IOVAs within that range and map then for each of
> those MSI doorbells. This is done in the MSI controller compose() callback.
> 
> I hope I succeeded in clarifying this time.
> 
> Robin sent today a new version of its cookie think using a dummy
> allocator. I am currently integrating it.

Okay, I understand. A simple bitmap-allocator would probably be
sufficient, and doesn't have the overhead the iova allocator has. About
how many pages are we talking here?


	Joerg
