From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu: Implement a dummy bus_set_iommu()
Date: Wed, 22 Oct 2014 16:29:22 +0200
Message-ID: <20141022142922.GH10074@8bytes.org>
References: <1406897113-20099-1-git-send-email-thierry.reding@gmail.com>
	<1406897113-20099-2-git-send-email-thierry.reding@gmail.com>
	<20140818165750.GE9809@8bytes.org> <20141015091043.GA13162@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141015091043.GA13162@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 15, 2014 at 11:10:44AM +0200, Thierry Reding wrote:
> It seems like I never got back to you on this. The reason here is that
> for Tegra the IOMMU is part of a larger IP block. The IP block is
> primarily a memory controller with a bunch of configuration knobs for
> arbitration, prioritization and whatnot. A smaller part of the device
> does the IOMMU translation. Therefore the IOMMU implementation would
> be part of a larger driver, and having this dummy would reduce the
> amount of #ifdefs required.
> 
> bus_set_iommu() is also the only function in include/linux/iommu.h that
> doesn't have a dummy, so it seemed like a natural thing to do.
> 
> That said, I can work around this being absent for !IOMMU_API.

Or you make this "larger driver" just depend on IOMMU_API? Otherwise you
need the #ifdefs anyway to not carry around the iommu-ops functions in
the driver without having the iommu core enabled, no?


	Joerg
