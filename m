From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 10/16] iommu: introduce device fault report API
Date: Fri, 8 Dec 2017 13:22:48 -0800
Message-ID: <20171208132248.60bd65e7@jacob-builder>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1510944914-54430-11-git-send-email-jacob.jun.pan@linux.intel.com>
	<20171207142725.731695ea@t450s.home>
	<20171208122358.720edd9d@jacob-builder>
	<20171208135909.0ee02d16@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171208135909.0ee02d16-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 8 Dec 2017 13:59:09 -0700
Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> > > 
> > > Isn't this all rather racy?  I see that we can have multiple
> > > callers to register racing.    
> > I agree, should use a lock here to prevent unregister. For multiple
> > caller race, it won't happen since there is only one caller can
> > register handler.  
> 
> If you have multiple simultaneous callers to
> iommu_register_device_fault_handler, they can all get past the test
> for fault_param (testing and setting is not atomic), then it's
> indeterminate which handler gets installed.  Thanks,
> 
I see, having the mutex would prevent it. Later callers would get
-EBUSY.
Thanks a lot!
> Alex
