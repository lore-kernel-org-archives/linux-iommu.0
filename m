From: "Hook, Gary" <ghook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v3 1/2] iommu - Enable debugfs exposure of the IOMMU
Date: Tue, 17 Apr 2018 13:36:33 -0400
Message-ID: <10e422dd-a3ca-8ecb-50fa-e7f131a55a12@amd.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
	<152302066417.47565.4017200105445420643.stgit@sosxen2.amd.com>
	<1523663790.2747.4.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1523663790.2747.4.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Mehta, Sohil" <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "gary.hook-5C7GfCeVMHo@public.gmane.org" <gary.hook-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 4/13/2018 7:55 PM, Mehta, Sohil wrote:
> On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
>>   
>>   
>> +struct dentry *iommu_debugfs_setup(void)
>> +{
>> +	if (!debugfs_initialized())
> 
> This check is probably not needed.

Ah, so it isn't. Thank you.

> 
>> +		return NULL;
>> +
>> +	if (!iommu_debugfs_dir)
>> +		iommu_debugfs_dir = debugfs_create_dir("iommu",
>> NULL);
>> +
>> +	if (iommu_debugfs_dir)
>> +		pr_warn("WARNING: IOMMU DEBUGFS SUPPORT HAS BEEN
>> ENABLED IN THIS KERNEL\n");
>> +
> 
> As this gets called for each IOMMU, do you want to use pr_warn_once?

That works, yes.

> 
>> +	return iommu_debugfs_dir;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_debugfs_setup);
> 
> -Sohil
> 
