From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/10] iommu/amd: copy old dev tables and do not touch
	dev tables
Date: Tue, 29 Sep 2015 18:08:08 +0200
Message-ID: <20150929160808.GO3036@8bytes.org>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
	<1443076656-31776-8-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1443076656-31776-8-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 24, 2015 at 02:37:33PM +0800, Baoquan He wrote:
> +		 if ( !translation_pre_enabled() ) {
> +			iommu_disable(iommu);
> +			iommu_init_flags(iommu);
> +			iommu_set_device_table(iommu);
> +			iommu_enable_command_buffer(iommu);
> +			iommu_enable_event_buffer(iommu);
> +			iommu_set_exclusion_range(iommu);
> +			iommu_enable(iommu);
> +			iommu_flush_all_caches(iommu);
> +		} else {
> +			copy_dev_tables();
> +			copy_command_buffer();
> +			copy_event_buffer();
> +		}

Hmm, this leaves the old device-table in place and removes flushing the
iommu-caches in kdump kernel, right?


	Joerg
